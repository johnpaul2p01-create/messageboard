(define-fungible-token networking-coin u1000000000)

(define-data-var total-liquidity u0)
(define-map user-liquidity principal u0)

(define-public (deposit-liquidity (amount u128))
  (begin
    (try! (ft-transfer? networking-coin amount tx-sender (as-contract tx-sender)))
    (var-set total-liquidity (+ (var-get total-liquidity) amount))
    (map-set user-liquidity tx-sender (+ (unwrap! (map-get? user-liquidity tx-sender) u0) amount))
    (ok amount)
  )
)

(define-public (withdraw-liquidity (amount u128))
  (let ((user-balance (unwrap! (map-get? user-liquidity tx-sender) (err u1))))
    (asserts! (>= user-balance amount) (err u4))
    (var-set total-liquidity (- (var-get total-liquidity) amount))
    (map-set user-liquidity tx-sender (- user-balance amount))
    (as-contract (try! (ft-transfer? networking-coin amount tx-sender tx-sender)))
    (ok amount)
  )
)

(define-read-only (get-total-liquidity)
  (ok (var-get total-liquidity))
)

(define-read-only (get-user-liquidity (user principal))
  (ok (unwrap! (map-get? user-liquidity user) u0))
)

;; For admin to mint initial supply
(define-public (mint (amount u128) (recipient principal))
  (ft-mint? networking-coin amount recipient)
)
