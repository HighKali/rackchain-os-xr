from eth_account import Account
import secrets

# Abilita generazione da seed
Account.enable_unaudited_hdwallet_features()

# Genera una seed phrase BIP39 (12 parole)
mnemonic = Account.create_with_mnemonic()[1]

# Deriva chiavi dal seed
acct = Account.from_mnemonic(mnemonic)

# Output orbitale
print("🌌 Wallet Ethereum/Polygon generato:")
print(f"🧿 Seed Phrase: {mnemonic}")
print(f"🔑 Indirizzo: {acct.address}")
print(f"🔐 Chiave Privata: {acct.key.hex()}")
