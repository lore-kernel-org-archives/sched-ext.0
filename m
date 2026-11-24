Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516167;
	b=jDnUoOX/hzkBvF+Zm+wCErV2rdNuDaMU9sNjR3QwoOKvy/XgAZzQ1L9J4rPK9qKibhqj
	 +EJD3cJqnwlNy8vP9B/yoXpYYppdylHMF+/gB43heoD0T8LyGwY/sa7mK69Z1ohPSkjVx
	 VDxyQ58wyqq9DYEVN211/PUpY0YEDSomif1B7+DFjLn/6tlu5WZ3N6MnLzjyLIIEB3XEf
	 RJ6Ne6tmYhtrWFAXU3seM4jSFQVHBiZNJZGPRRHMJo+FzBOkMRdvSYZKenC68STkYkAgU
	 +dh4IMCx7QVFgibsOk2m2i1/E+uk0Q87O1Xgl1PEXnK4xv8hq6UCIzQFN9A7CA8UVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NgR3m63+SnytcglSpFEsTa+pIxMIxJNpneEFbxbVTZ0=;
	b=d4gmvADybpT+O8LerrzNrot5wqy80nelzyNFDAK08HT1Sc8wKkIYBdydTZh7/IlwWR01
	 oUXYw90c/K/hm1bL3PAiHSdJvMSaHmOiXx7iVreprR5IrRIHl9MXkTgeVugUH7uP1BMov
	 +HyznSaMQU9inH6O9BrUMa1GNTzy48FjwUOVBqVQH74p5/mnLZBJbYlQc4HSQLcB3Yjdb
	 piOCeqLqxcoQL50dPg+p/hCOgG8KwNbhD6zjLXM3rx5LCrKohg/vfTiRg+WwvHSiXgkBh
	 EadTjHRyHswqMwGPkIrze+TCPu60qg9m0yokzpTIqxOWRuHsWS8XQRuKKjkdXCLEr6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eELhBYH6;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E91606A32E
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 10:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E91606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eELhBYH6
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50549f6cf1so274659066b.3
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 02:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795516166; x=1796120966; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgR3m63+SnytcglSpFEsTa+pIxMIxJNpneEFbxbVTZ0=;
        b=eELhBYH6FvKvWT+COhVQ3mmcpUEY8dlFTTr2hw6yCs6iG8FNIL5fIMGZlV+/CNQBfv
         Swct3CAmx0eu7jPk0DlsRkXdUbqDkrp0/fHP2beMLs90o44kalvEsOo/kGzcZhZk1RnE
         /GKqHlnJ2CRpe25zW93BOgcrZWtPi8yohutj55uyaQ2fQV0FeHmzQ6BxHu2XhmZ3jtAc
         B/aVDrkYCdrcZ1Ga7U/ouoBTSv4YZpdI/V3P1DW4o3tM6vfrorSaC56m2izcr10E0MFZ
         FS+gmB99i1z/TpIpqinaBXR8+EkUMbX130B4P52tEFPwyY0zJnI5HAuxLEqDboJonr/6
         lF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516166; x=1796120966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgR3m63+SnytcglSpFEsTa+pIxMIxJNpneEFbxbVTZ0=;
        b=g/3xnRwtdkK82A8N7IPzHGsEg/s3cTs4OsV1SxtNjm5HiV8yKRU2w/D6Q81kZVygLx
         frZ9kEcax2Jl/Mb8NLZ6FMXPL2CoSmfxqDzsdtb2kZm+N4OdlyuWVNhWfzu2uKxEXLgT
         ps7o6fhx2NcYLsmtQqa3AT/vQdXEIWF4IPYia6xgyBe7+0uiBXRYp4YsqXeM1kQYNB6Z
         /vczb5d/SkPqezo/Q31tJ/j4Pwsxxv+P44I5vPvvvcf2GdLjdgSrVtZVdpgz6J0gRKCT
         +HjZXqestIAl/FemOt5pawqfjuiv7GlmoBkJn7hgfOsmG4BMRLIKz2tmZ4HKMqyPgbRO
         nDHQ==
X-Forwarded-Encrypted: i=1; AL+hErGTHM5GuiNXOG6xIVHMiu7aNrWYX1ZHcOexujRltMgVE8vTLAnnqpmSt26HBR5TDrBIZuTGWEEKgAY=@lists.linux.dev
X-Gm-Message-State: APuU4Z9Vh92P9SimqEqd85K6691p3BezeV+ya5JnooRbKgsoXt/0G6QG
	3rvQ4p+ZyqCiZoPg2pITWnAeSgpoDznAJxvPlYnZSmxCZkRi5NE6tJ13bIVMj/jXvnXxUSgeLCr
	1zoieV8g0En++9g==
X-Received: from ejex11.prod.google.com ([2002:a17:906:298b:b0:c50:7d13:f19a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:b053:20b0:c49:8fa2:4a22 with SMTP id a640c23a62f3a-c513acaefdfmr762232966b.41.1795516165548;
 Tue, 24 Nov 2026 02:29:25 -0800 (PST)
Date: Tue, 24 Nov 2026 10:29:23 +0000
In-Reply-To: <awVEqEZdHReap399@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123145927.577162-1-jpiecuch@google.com> <20261123145927.577162-3-jpiecuch@google.com>
 <awVEqEZdHReap399@gpd4>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124102813.217423-2-jpiecuch@google.com>
Subject: Re: [PATCH 2/2] sched_ext: Take rcu_read_lock() explicitly in sub-cap kfuncs
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Tue, 24 Nov 2026 08:02, Andrea Righi wrote:
> I'd drop this patch. The IRQ-disabled region already provides the
> required lifetime protection and the existing checks recognize it.
>
> If a future change introduces another dereference here, it should use
> the check appropriate to that protection, such as rcu_dereference_all().
>
> I think we don't want to introduce additional RCU read-side bookkeeping
> on every call to accommodate that possibility.

Makes sense, especially with patch 1 switching to rcu_dereference_all()
as well. Will drop this patch in v2.

Thanks,
Kuba
