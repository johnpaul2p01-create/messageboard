;; contracts/proof.clar
;; ProofOfExistence - Document Notary
;; Users can register document hashes on-chain as proof of existence.

(define-map proofs
  { owner: principal, hash: (buff 32) }
  uint
)

;;  Register a document hash (SHA256 digest, 32 bytes)
(define-public (register (doc-hash (buff 32)))
  (begin
    (map-set proofs { owner: tx-sender, hash: doc-hash } block-height)
    (ok block-height)
  )
)

;; --- Views ---
(define-read-only (get-proof (who principal) (doc-hash (buff 32)))
  (map-get? proofs { owner: who, hash: doc-hash })
)
