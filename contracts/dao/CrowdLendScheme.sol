pragma solidity ^0.4.24;

import "@daostack/arc/contracts/universalSchemes/UniversalScheme.sol";
import "@daostack/arc/contracts/universalSchemes/ExecutableInterface.sol";
import "@daostack/arc/contracts/VotingMachines/IntVoteInterface.sol";
import "@daostack/arc/contracts/controller/ControllerInterface.sol";
import "./DebtorDaoInterface.sol";

contract CrowdLendScheme is UniversalScheme, ExecutableInterface {
    event NewDebtProposed(
        address indexed _proposer,
        bytes32 indexed _proposalId,
        uint reputationChange
    );

    event ProposalExecuted(
        bytes32 _proposalId,
        int _param
    );

    struct DebtProposal {
        bytes32 TermsParameter;
        address proposer;
        address principalToken;
        uint principalAmount;
        uint reputationChange;
    }

    struct Parameters {
        bytes32 voteApproveParams;
        IntVoteInterface intVote;
    }

    address public debtorDaoContract;
    Parameters public controllerParam;

    function setParameters(
        bytes32 voteApproveParams,
        IntVoteInterface _intVate
    )
    public
    {
        controllerParam.voteApproveParams = voteApproveParams;
        controllerParam.intVote = _intVote;
    }

    function proposeDebt(
        bytes32 TermsParameter
        address principalToken,
        uint PrincipalAmount,
        uint reputationChange,
    ) 
    public
    returns(bytes32)
    {
        bytes32 proposalId = controllerParam.intVote.propose(
            
        );
        emit NewDebtProposed(msg.sender, proposalId, reputationChange);
    }

    function execute(bytes32 proposalId, address avatar, int param)
    public
    returns(bool)
    {
        emit ProposalExecuted(proposalId, param);
        return true;
    }

    constructor(address _debtorDaoContract) public {
        debtorDaoContract = _debtorDaoContract;
    }
}
