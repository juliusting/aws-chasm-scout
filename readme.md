# Chasm Network Scout Season 0 AWS Hosting Tutorial

Follow steps on https://superoo7.com/posts/chasm-network-scout-hosting/

DO
Step 1: Mint NFT to Get Scout ID and API Key 
Step 2: Get Groq API Key 

Skip DigialOcean Step 3 and 4 for AWS Step below

## Open AWS account
1. Create EC2 Ubuntu Instance
2. Create Elastic IP
    - Associate Elastic IPs to EC2 Ubuntu Instance
3. EC2 > Security Groups > your_launch_wizard_security_group (linked to your instance)
    - Edit inbound rules 
        - Custom TCP port 3001
    - Edit outbound rules 
        - Custom TCP port 3001

Replace WEBHOOK_URL in .env file
WEBHOOK_URL=http://<ELASTIC_IP>:3001/

Continue Step 5: Setup Server 
1. SSH into your server (You can click connect on the AWS website instance)
2. run `sudo sh docker-installer.sh`
3. refresh the terminal page because `docker-installer.sh` reboots after installation for a smoother run
4. run `sh start_scout.sh`
5. Verify using Superoo7's code below:

# Test Server Response:
## Should get "OK" response
`curl localhost:3001`

You should get a response like:
`ubuntu@ip-172-123-123-123:~$ curl localhost:3001`

`OKubuntu@ip-172-123-123-123:~$`

`^ Note the OK`

# Test LLM
`source ./.env
curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $WEBHOOK_API_KEY" \
     -d '{"body":"{\"model\":\"gemma2-9b-it\",\"messages\":[{\"role\":\"system\",\"content\":\"You are a helpful assistant.\"}]}"}' \
     $WEBHOOK_URL
`

## EXAMPLE Test LLM
`ubuntu@ip-172-123-123-123:~$ source ./.envnv
curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $WEBHOOK_API_KEY" \
     -d '{"body":"{\"model\":\"gemma2-9b-it\",\"messages\":[{\"role\":\"system\",\"content\":\"You are a helpful assistant.\"}]}"}' \
     $WEBHOOK_URL
{"id":"chatcmpl-xx-xx-xx-xx-xx","object":"chat.completion.chunk","created":1721445257,"model":"gemma2-9b-it","system_fingerprint":"xx","choices":[{"index":0,"message":{"role":"assistant","content":"That's right! I'm here to help in any way I can.\n\nWhat can I do for you today? 😊  \n"},"finish_reason":"stop","logprobs":null}],"x_groq":{"id":"xx","usage":{"queue_time":0.022309279,"prompt_tokens":21,"prompt_time":0.002741011,"completion_tokens":31,"completion_time":0.063135737,"total_tokens":52,"total_time":0.065876748}},"usage":{"prompt_tokens":0,"completion_tokens":31,"total_tokens":31},"scout":{"provider":"groq","model":"gemma2-9b-it"}}`