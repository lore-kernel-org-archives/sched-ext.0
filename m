Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D912C15AB
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468508; cv=none; b=ElJNLcM7uTJWv//ifVmSHNu5X+c8ctGypf0FomKDugNAYNMfkXcbF6AQskfMgXDUfXpz6hstA1QA4NPww+iatHwCMQ0889CgaoORvU5/st1Vrdk0VMaSVBQ5IUDJSzuhjkiHO8i6G0ray1CzVPRUgS7Fb/oi8rcCB7QGzzkSfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468508; c=relaxed/simple;
	bh=fwJlp95bBAG7kWYEepDiexqrENbAswzXKepyzd027WM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VlU+21F5SH82JO6joPmMboVfMnKux9EBpxeUodItTD6Wf5H1Ctg/JZc1mJdDqPaP7R9N2Li/ZapKOLxOjFioOC2u19C2c5tuW5JzxJE36zOJd+XXdFc4KTy2hbh22qvoWoLcelikvPsjvgdEPKTxBkftXwUc0ld8CL2sFQryl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI8ifwo3; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI8ifwo3"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c52fa75cd3so193722a34.3
        for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765468504; x=1766073304; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ie7TKY4J0xZBKToVZGBoQ4XnO54sW4jqYAqWGv0+/io=;
        b=NI8ifwo3eR+AbeTHmKShjnTe6WDBgvtl5sSfOscgOY7zcn13nbxQvqPoyxt+Z6sGQt
         BHUhLc06nhFXlK0mINyAB8qDpzR+qsYi89Y4dudR/T5HLpLb7YQFVMhvsg1RSZgANb5q
         QppYogIDxVI7hY5rjaU9/2TKYbSXB+JjkXoVRPiuvMv1OIE+hjXDYUayqwJdD6xwH3JR
         kdU+zudUKlMNVzw1TJPMYKWpkHHKNa4KT6FwkZROuiwNB+LAERGi0bPhYVjU+zNO50Wu
         EUZq/fNVl43Tvi+6f3ZdVdW875bfdWarvr82HBvHMiCrkYxV/X+uPZ2mAwawyyEnhdVG
         wpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765468504; x=1766073304;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie7TKY4J0xZBKToVZGBoQ4XnO54sW4jqYAqWGv0+/io=;
        b=lvTgWsXhz4NHAdXcPERo9RwlOirLmHabV5GYEnjC480o8r+PP0+0CN+ZJGTIyQwQkd
         Te57QGPsrIFYxgHgreAbH611K6FOkebnof7CWhnrggO6U6mW1ibsMOglu9bH1B16xhSF
         p8RAWnjTsAGKHxrDN8s4kj5UmJtdYA+AYcMJob0kazIx/qpuryeXdyLGgUFXoHbT7y7C
         9xIwuBVmEElGEARrktUHyI602NQ9b7N8v00aWFtjjN4pmP2f9do+n3qJ8208FKQn+z5S
         qRoKd7W6JMmhu7p2fmaYzfOXle6yQnYnd1ZGnX+1+bjhNiunrQAQ8MouqZuoW6B+cvhu
         nQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPfviCWYk8sc9L61w1MQ0LJ4A1kFcJ2yFHjwXYhauFJZtw7aTQ2uAWSdsarIYGNTf0wwe6Qg1dhq4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy45br0I5MP/z1iNHRj8IIFeIxKgg7SHH6mkojcEPmGAte3cDI
	UuRrYqBDHMVP9hOTGsdSp6004+XC8SwmBlfxrkViHsU/CsBpkZqyTueOjesCxx86ii1+FvEDH8a
	xcSUG7X4l6nZ1qpfBA6vQ38fg/bqIf7c=
X-Gm-Gg: AY/fxX6ibFLJYf+f87h+niIfEGMRO//V0wxIU3hjKaKyeZyNYSIzsV/waZg8DO0vxs4
	hIv1DwowfWZsXBLNfIgwxE5egLRlXZBwYTDWzUcn7vvxPe5XiYK455rmN+IKdgJUbMRiK9B1NdC
	vtovaEgp5qrG4dRVgzeEyS4kc49Lbb4tR1ltcfSJNP0DH+5h3ofM0h2BfcJ0sA047CgJaK7V5u2
	f/ZFi0MzdZ5XZs+grLGy6YlsHLsSOn2osNbe+g5r6XMikrAlyjooQsh3+6dETJfBI8MtpILEEwk
	UEWEvpcPCcSeD65JxU84guNNpg==
X-Google-Smtp-Source: AGHT+IHXmInc6hNUIZUoLpP+BYGgYAGze6nb2R2ueRO5VxDEQRxgtOjiPMFdP1lK2Otb1LgPycnughbDIgBoXGBKCXE=
X-Received: by 2002:a05:6808:1490:b0:439:af2f:d1d5 with SMTP id
 5614622812f47-455866d189amr3237813b6e.39.1765468504472; Thu, 11 Dec 2025
 07:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 11 Dec 2025 15:54:53 +0000
X-Gm-Features: AQt7F2ougg8Kbtn1zopP4MM0jMFAvN_Q8zACcGkXN_X9ACZRAZQLHfVWaA3hLE0
Message-ID: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
Subject: Concerns with em.yaml YNL spec
To: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I just spotted the new em.yaml YNL spec that got merged in
bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
because it introduced new yamllint reports:

make -C tools/net/ynl/ lint
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
yamllint ../../../Documentation/netlink/specs
../../../Documentation/netlink/specs/em.yaml
  3:1       warning  missing document start "---"  (document-start)
  107:13    error    wrong indentation: expected 10 but found 12  (indentation)

I guess the patch series was never cced to netdev or the YNL
maintainers so this is my first opportunity to review it.

Other than the lint messages, there are a few concerns with the
content of the spec:

- pds, pd and ps might be meaningful to energy model experts but they
are pretty meaningless to the rest of us. I see they are spelled out
in the energy model header file so it would be better to use
perf-domain, perf-table and perf-state here.

- I think the spec could have been called energy-model.yaml and the
family called "energy-model" instead of "em".

- the get-pds should probably be both do and dump which would give
multi responses without the need for the pds attribute set (unless I'm
missing something).

- there are 2 flags attributes that are bare u64 which should have
flags definitions in the YNL. Have a look at e.g. netdev.yaml to see
examples of flags definitions.

- the cpus attribute is a string which would appear to be a "%*pb"
stringification of a bitmap. That's not very consumable for a UAPI and
should probably use netlink bitmask or an array of cpu numbers or
something.

- there are no doc strings for any of the attributes. It would be
great to do better for new YNL specs, esp. since there is better
information in energy_model.h

Given that netlink is UAPI, I think we need to address these issues
before v6.19 gets released.

Thanks,
Donald Hunter.

[1] https://lore.kernel.org/all/20251020220914.320832-4-changwoo@igalia.com/
