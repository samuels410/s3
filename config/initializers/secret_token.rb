# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
S3::Application.config.secret_key_base = '7c82d5daddb5d8540a11949b34f708782e260d8de082707f9902bb091ac403f3b9ce0c18ddf1aa5f0dd59a50f5ad17341002ffb2a74760f9fe1d6e44149930d0'
