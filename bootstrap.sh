#!/bin/bash

cd
cp ~/chef-fs-photos/aws.json ~/chef-fs-photos/solo.rb /
cd /
chef-solo -c solo.rb -j aws.json
