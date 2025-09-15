# 🌐 ProofOfExistence – On-Chain Document Notary

ProofOfExistence is a **breathtakingly simple, powerful contract** on Stacks.  
It allows anyone to **register a document hash** (e.g., legal file, artwork, source code) permanently on-chain, proving that it existed at a certain moment in time.  

---

## ✨ Features
- 🌐 **Register SHA256 hash** of any file/document  
- ⏳ **Timestamp proof** of existence at block-height  
- 🔍 **Publicly verifiable** – anyone can check it  
- 🛡️ **Tamper-proof** – stored immutably on-chain  

---

## 🚀 Example Usage

### Register a Document
```clarity
(contract-call? .proof register 0xabc123...32bytes...)
