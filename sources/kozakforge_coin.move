module kozakforge_coin::kozakforge_coin;

use sui::coin::{Self, TreasuryCap};
use sui::coin_registry;

public struct KOZAKFORGE_COIN has drop {}

fun init(witness: KOZAKFORGE_COIN, ctx: &mut TxContext) {
    let (currency, treasury_cap) = coin_registry::new_currency_with_otw(
        witness,
        7,
        b"KFC".to_string(),
        b"KozakForge Coin".to_string(),
        b"Coin for real Kozaks".to_string(),
        b"https://raw.githubusercontent.com/DrEverr/kozakforge_coin/refs/heads/main/assets/KozakForgeCoin.png".to_string(),
        ctx
    );

    let metadata = currency.finalize(ctx);
    let sender = tx_context::sender(ctx);

    transfer::public_transfer(treasury_cap, sender);
    transfer::public_transfer(metadata, sender);
}

public fun mint_to_self(cap: &mut TreasuryCap<KOZAKFORGE_COIN>, amount: u64, ctx: &mut TxContext) {
    coin::mint_and_transfer(cap, amount, tx_context::sender(ctx), ctx);
}

