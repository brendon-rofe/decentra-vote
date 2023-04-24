# DecentraVote

DecentraVote is a decentralized voting system built using Express.js, MongoDB, Ethers.js, and Solidity. This project aims to provide a secure, transparent, and tamper-proof platform for conducting elections and decision-making processes across various sectors.

## Target Audience

- Government organizations
- Educational institutions
- Non-profit organizations and associations
- Corporations
- Online communities

## Features

- Decentralized and secure voting system using Ethereum smart contracts
- Role-based access control for administrators and voters
- User authentication and management
- Support for creating, managing, and participating in elections
- Real-time election results and data retrieval

## System Requirements

- Node.js v14.x or higher
- MongoDB v4.x or higher
- Ethereum development environment (Ganache or Hardhat)
- Metamask or another Web3-compatible wallet (for deployment and testing)

## Getting Started

### 1. Clone the repository

```
git clone https://github.com/yourusername/DecentraVote.git
```
```
cd DecentraVote
```

### 2. Install dependencies

```
npm install
```

### 3. Set up the environment

Create a .env file in the root directory with the following variables:

```
MONGODB_URI=mongodb://<username>:<password>@<hostname>:<port>/<database>
SECRET_KEY=<your_secret_key>
ETH_NETWORK=<ethereum_network_url>
PRIVATE_KEY=<your_ethereum_private_key>
```

### 4. Compile and deploy the smart contracts

```
npm run compile
npm run deploy
```

### 5. Run the server

```
npm start
```

The server will start running at http://localhost:3000.

## API Endpoints

### Authentication
- POST /api/auth/register
- POST /api/auth/login
- GET /api/auth/logout

## Election Management
- POST /api/election/create
- GET /api/election/:id
- GET /api/election
- PUT /api/election/:id
- DELETE /api/election/:id

## Voting
- GET /api/election/:id/vote
- POST /api/election/:id/vote

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any bugs, features, or improvements.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
