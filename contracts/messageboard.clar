;; contracts/messageboard.clar
;; On-chain Message Board
;; - Users can post messages
;; - Anyone can read all messages

(define-data-var message-id uint u0)

(define-map messages
    { id: uint }
    {
        sender: principal,
        text: (string-ascii 100),
        timestamp: uint,
    }
)

;; --- public function to post a message ---
(define-public (post (text (string-ascii 100)))
    (let ((id (+ u1 (var-get message-id))))
        (begin
            (var-set message-id id)
            (map-set messages { id: id } {
                sender: tx-sender,
                text: text,
                timestamp: block-height,
            })
            (ok id)
        )
    )
)

;; --- read-only function to get message by id ---
(define-read-only (get-message (id uint))
    (map-get? messages { id: id })
)

;; --- read-only function to get latest message ---
(define-read-only (get-latest)
    (map-get? messages { id: (var-get message-id) })
)

;; --- read-only function to get message count ---
(define-read-only (get-count)
    (var-get message-id)
)