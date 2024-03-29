use starknet::ContractAddress;

#[starknet::interface]
trait ApeDriveNFTTrait<TContractState> {
    fn mint(ref self: TContractState, recipient: ContractAddress);
}

#[starknet::contract]
mod ApeDriveNFT {
    use openzeppelin::introspection::src5::SRC5Component;
    use openzeppelin::token::erc721::ERC721Component;
    use starknet::ContractAddress;

    component!(path: ERC721Component, storage: erc721, event: ERC721Event);
    component!(path: SRC5Component, storage: src5, event: SRC5Event);

    // ERC721
    #[abi(embed_v0)]
    impl ERC721Impl = ERC721Component::ERC721Impl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721MetadataImpl = ERC721Component::ERC721MetadataImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721CamelOnly = ERC721Component::ERC721CamelOnlyImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721MetadataCamelOnly =
        ERC721Component::ERC721MetadataCamelOnlyImpl<ContractState>;
    impl ERC721InternalImpl = ERC721Component::InternalImpl<ContractState>;

    // SRC5
    #[abi(embed_v0)]
    impl SRC5Impl = SRC5Component::SRC5Impl<ContractState>;

    #[storage]
    struct Storage {
        token_id: u256,

        #[substorage(v0)]
        erc721: ERC721Component::Storage,
        #[substorage(v0)]
        src5: SRC5Component::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        ERC721Event: ERC721Component::Event,
        #[flat]
        SRC5Event: SRC5Component::Event
    }

    #[constructor]
    fn constructor(
        ref self: ContractState
    ) {
        let name = 'ApeDrive Car';
        let symbol = 'CAR';

        self.erc721.initializer(name, symbol);
    }

    #[external(v0)]
    impl ApeDriveNFTImpl of super::ApeDriveNFTTrait<ContractState> {
        fn mint(
            ref self: ContractState,
            recipient: ContractAddress
        ) {
            // Initialize the ERC721 storage
            self.erc721._mint(recipient, self.token_id.read());
            
            // Mint the NFT to recipient and set the token's URI
            // self.erc721._set_token_uri(token_id, token_uri);

            // Increase token ID
            self.token_id.write(self.token_id.read() + 1);
        }
    }
}