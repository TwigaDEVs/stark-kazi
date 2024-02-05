use starknet::ContractAddress;
// entry point of the main contract
#[starknet::interface]
trait IStarkKazi<TContractState> {
    fn addNewFreelancer(ref self: TContractState, full_name: felt252, profile_image: felt252, hourly_rate: u32, profession: felt252, preferred_payment: felt252, skill: felt252, is_profile_public: bool);
    fn edit_freelancer_profile(ref self: TContractState, full_name: felt252, hourly_rate: felt252, profession: felt252,preferred_payment: felt252, skills: Array<felt252>);
    fn set_profile_visibility(ref self: TContractState, is_profile_public: bool);
    fn get_freelancer(ref self: TContractState, freelancer_address: ContractAddress);
    fn post_a_client_job(ref self: TContractState, project_title: felt252, project_description: felt252, project_duration: u32, project_budget: felt252, skill_requirements: Array<felt252>, images: Array<felt252>);
}


#[starknet::contract]
mod StarkKazi {
use starknet::ContractAddress;

    use core::starknet::event::EventEmitter;
    use core::traits::Into;
    use core::option::OptionTrait;
    use core::traits::TryInto;
    use starknet::{get_caller_address, get_block_timestamp, get_contract_address};
    


    
    #[storage]
    struct Storage {
        freelancers: LegacyMap<ContractAddress, Freelancer>,
        freelancer_count: u32,
        bid_count: u32,
        
    }

    #[derive(Drop)]
    struct  Freelancer {
        account_id: ContractAddress,
        profile_image: felt252,
        full_name: felt252,
        hourly_rate: u32,
        profession: felt252,
        payment_preference: felt252,
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

    #[external(v0)]
    impl StarkKazi of super::IStarkKazi<ContractState> {
        fn addNewFreelancer(ref self: ContractState, full_name: felt252, profile_image: felt252, hourly_rate: u32, profession: felt252, preferred_payment: felt252, skill: felt252, is_profile_public: bool){
            let freelancer_address: ContractAddress = get_caller_address();
            let existing_freelancer = self.freelancers.read(freelancer_address);
            if (existing_freelancer.account_id != freelancer_address){
                let freelancer: Freelancer = Freelancer {
                    account_id: freelancer_address,
                    full_name: full_name,
                    profile_image: profile_image,
                    profession: profession,
                    hourly_rate: hourly_rate,
                    payment_preference: preferred_payment,
                    skills: array![],
                    profile_rating: 0,
                    is_profile_public: true

                };
                self.freelancers.write(freelancer_address, freelancer);
                self.freelancer_count.write(self.freelancer_count.read() + 1);
            }
        }

        
    }

     fn edit_freelancer_profile(ref self: ContractState, full_name: felt252, hourly_rate: u32, profession: felt252,preferred_payment: felt252, skills: Array<felt252>){
        let freelancer_address: ContractAddress = get_caller_address();
            let existing_freelancer = self.freelancers.read(freelancer_address);
            if (existing_freelancer.account_id != freelancer_address){
                let freelancer: Freelancer = Freelancer {
                    account_id: freelancer_address,
                    profile_image: existing_freelancer.profile_image,
                    full_name: full_name,
                    profession: profession,
                    hourly_rate: hourly_rate,
                    payment_preference: preferred_payment,
                    skills: skills,
                    profile_rating: existing_freelancer.profile_rating,
                    is_profile_public: true

                };
                self.freelancers.write(freelancer_address, freelancer);
                self.freelancer_count.write(self.freelancer_count.read() + 1);
            }

            
     }

      fn set_profile_visibility(ref self: ContractState, is_profile_public: bool){
        let existing_freelancer = self.freelancers.read(get_caller_address());
     }

     fn get_freelancer(ref self: ContractState, freelancer_address: ContractAddress) -> Freelancer {
        let existing_freelancer = self.freelancers.read(freelancer_address);
        existing_freelancer
     }

     

    fn post_a_client_job(ref self: ContractState, project_title: felt252, project_description: felt252, project_duration: u32, project_budget: felt252, skill_requirements: Array<felt252>, images: Array<felt252>){
        let caller_address = get_caller_address();

    }

    
}
#[cfg(test)]
mod tests {
    
}
