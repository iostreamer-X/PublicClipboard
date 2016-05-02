# PublicClipboard
Make your clipboard content accessible via HTTP to other devices on your network. Currently only for linux.

# Dependencies
`sudo apt-get install xclip`

# Install
`npm install -g public_clipboard`

# Run
`public_clipboard`

# Instructions

- The app runs on port 8080. To access the public clipboard visit `<your-ip:8080>`.
- You can also clear the content of your public clipboard by entering `clear`.

# Use cases

- You want to send your phone a link and forward it via WhatsApp. There are apps and extensions which do this already, BUT, this solution works out of the box. No account, no android app, no hassle.

- You are in college, just wasting your time on Reddit and stumbled upon an [interesting link](https://www.reddit.com/user/_9MOTHER9HORSE9EYES9). You want to share it with your friends. Now, rather than opening Messenger(which could take time or you don't want to login), you could just copy the link and voilà, your friends get fast access(because local network) and you didn't have to do anything.

# Contribution

The app is written in Coffeescript with backend powered by Node and frontend by Backbone. You could help in porting this app to other Operating Systems. Currently it's for Linux because of dependency on `xclip`. 



# Demo
![](./scrsht.png)

![](./scrshtm.png)

# Remarks
publicboard.com is being resolved through my local dns server running on my laptop.
