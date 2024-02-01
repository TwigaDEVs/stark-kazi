// entry point of the main contract


#[starknet::contract]
mod KaziKrypto {
use starknet::ContractAddress;

    use core::starknet::event::EventEmitter;
    use core::traits::Into;
    use core::option::OptionTrait;
    use core::traits::TryInto;
    use starknet::{get_caller_address, get_block_timestamp, get_contract_address};
    


    
    #[storage]
    struct Storage {
        
        
    }

    struct  Freelancer {
        account_id: ContractAddress,
        profile_image: felt252,
        full_name: felt252,
        hourly_rate: u32,
        profession: u32,
        payment_preference: u32,
        skills: Array<felt252>,
        profile_rating: usize, 
        is_profile_public: bool
    }

    struct FreelancerPortfolio {
        account_id: ContractAddress,
        from_date: felt252,
        toDate: felt252,
        jobTitle:felt252,
        jobDescription: felt252
    }

    struct ClientJobs {
        job_id: u32,
        account_id: ContractAddress,
        projectTitle: felt252,
        project_description: felt252,
        project_duration: felt252,
        project_budget: u256,
        skill_requirements: Array<felt252>,
        images: Array<felt252>,
        bid_available: bool
    }

    struct FreelancerBids {
        job_id: u32,
        bid_id: u32, 
        account_id: ContractAddress,
        bid_description: ContractAddress,
        budget: u256,
        relevant_files: Array<felt252>,
        bid_approved: bool
    }

    struct ProjectMilestones {
        bid_id: u32,
        milestone_id: u32,
        milestone_name: felt252,
        milestone_description: felt252,
        milestone_budget: u256,
        milestone_duration: usize,
        milestone_work_approved: bool,
    }

    struct Chats {
        timestamp: u256,
        sender: ContractAddress,
        receiver: ContractAddress,
        message: felt252,
        attached_files: Array<felt252>,
        seen: bool,
    }

    struct Transaction {
        from: ContractAddress,
        to: ContractAddress,
        transaction_purpose: felt252,
        transaction_amount: u256,
        timestamp: usize,
        transaction_status: felt252

    }
    
}
#[cfg(test)]
mod tests {
    
}
