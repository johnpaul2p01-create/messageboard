import { Clarinet, Tx, Chain, Account, types } from "clarinet";

Clarinet.test({
  name: "Users can post and read messages",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    let alice = accounts.get("wallet_1")!;
    let bob = accounts.get("wallet_2")!;

    // Alice posts "Hello"
    let block = chain.mineBlock([
      Tx.contractCall("messageboard", "post", [types.ascii("Hello World")], alice.address),
    ]);
    block.receipts[0].result.expectOk().expectUint(1);

    // Bob posts "GM"
    block = chain.mineBlock([
      Tx.contractCall("messageboard", "post", [types.ascii("GM")], bob.address),
    ]);
    block.receipts[0].result.expectOk().expectUint(2);

    // Get latest message
    let latest = chain.callReadOnlyFn("messageboard", "get-latest", [], alice.address);
    latest.result.expectSome()
      .expectTuple()["text"]
      .expectAscii("GM");

    // Check total count
    let count = chain.callReadOnlyFn("messageboard", "get-count", [], alice.address);
    count.result.expectUint(2);
  },
});
