---
kind: article
created_at: 2011/12/18
title: "Nibless AppKit Development"

---

# Nibbless AppKit Development #

Interface Builder, no matter how you slice it, is terrible. It may provide an
excellent visual way to create your application's GUI but it then also generates
large XML files that represent code. I think having opaque XML files that are
responsible for creating your views, and littering your code with macros like
`IBOutlet` and `IBAction` is not the way to do development.

Other people agree
