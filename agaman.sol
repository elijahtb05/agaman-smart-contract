// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

/**
 * @title CrossBorderRemittanceDummy
 * @notice FX happens off-chain. This version uses native currency (ETH/BNB/etc.)
 *         so you can perform a dummy transaction without deploying a token.
 */

contract CrossBorderTransactionDummy {
    address public owner;
    address public centralBankWallet;   // Dummy Bangladesh central bank wallet

    struct Remittance {
        address sender;
        uint256 amountSent;
        string senderCountry;
        string beneficiaryBank;
        string paymentReference;
        uint256 timestamp;
    }

    Remittance[] public remittances;

    event RemittanceSent(
        uint256 indexed id,
        address indexed sender,
        uint256 amountSent,
        string senderCountry,
        string beneficiaryBank,
        string paymentReference
    );

    constructor() {
        owner = msg.sender;

        // Dummy Bangladesh central bank address
        centralBankWallet = 0x1111111111111111111111111111111111111111;
    }

    /**
     * @notice Sends a dummy remittance to the central bank wallet.
     * @dev Uses native currency so you can test instantly in Remix.
     */
    function sendDummyRemittance(
        string calldata _senderCountry,
        string calldata _beneficiaryBank,
        string calldata _paymentReference
    ) external payable {
        require(msg.value > 0, "Must send some value");

        // Forward funds to dummy central bank wallet
        (bool success, ) = centralBankWallet.call{value: msg.value}("");
        require(success, "Transfer failed");

        remittances.push(
            Remittance({
                sender: msg.sender,
                amountSent: msg.value,
                senderCountry: _senderCountry,
                beneficiaryBank: _beneficiaryBank,
                paymentReference: _paymentReference,
                timestamp: block.timestamp
            })
        );

        emit RemittanceSent(
            remittances.length - 1,
            msg.sender,
            msg.value,
            _senderCountry,
            _beneficiaryBank,
            _paymentReference
        );
    }

    function getRemittanceCount() external view returns (uint256) {
        return remittances.length;
    }

    function getRemittance(uint256 id)
        external
        view
        returns (
            address sender,
            uint256 amountSent,
            string memory senderCountry,
            string memory beneficiaryBank,
            string memory paymentReference,
            uint256 timestamp
        )
    {
        Remittance memory r = remittances[id];
        return (
            r.sender,
            r.amountSent,
            r.senderCountry,
            r.beneficiaryBank,
            r.paymentReference,
            r.timestamp
        );
    }
