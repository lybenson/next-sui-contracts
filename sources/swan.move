// swan coin

#[lint_allow(share_owned)]
module swan::swan {
    use std::option;
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::TxContext;

    struct SWAN has drop {}

    fun init(witness: SWAN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<SWAN>(witness, 6, b"ETH", b"Ethereum", b"https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(treasury_cap);
    }

    public entry fun mint(treasury_cap: &mut TreasuryCap<SWAN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }
}
