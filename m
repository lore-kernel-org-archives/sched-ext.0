Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BE3164A1
	for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796350; cv=none; b=iAqYYQZ5b+FFe/FZAHTDCmTQraOYf+Fr0ke5JCmASQLKo8sZ/M/GDdRWpaCMkNd88pl8MqGpjhcvH+2DLl0UrM+ycBR67njZO5NXBg0ugKSGUOoTnT0KkmixBI2/Nl1Pg4wl2KDiyscKqLhsv6BgdvhYfghZhoHfBqeVQkJE+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796350; c=relaxed/simple;
	bh=S4rPeEDIZIwVJq/NhrUpwMxIVRW5R+/pHkM/PxZ/krQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=usrAdK8SnZQKIOugfgVDvok4hM65S8Sfp4OhPP4JRZIRSm7jUzEktPfqCpJ8VTuuJdpg8WAXDQydaJgB6om2+hTRi1+14InrdzQwscZVdPm0bX/CMw+6lNIaqt9lwUG0GqVrU90kGL/mM0Hnw0JckRrBu3KthkvchEmwzjY3Vn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn5d6Mzg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn5d6Mzg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so41751985e9.1
        for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765796346; x=1766401146; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFFtPLWt5GXwFQD6gQTfn7/fmcFvMDxSdb3CyQqoRRc=;
        b=Fn5d6MzgV2j1al73Hy7j9PyY0tFAqa1j5NwJ8OAtMlA3v2T5t8eaA8+9dN/Ff2vYSg
         +hwDHonHiqwf58adpj2TgX4E9ziHWMRyjJTiLfHifGj84NwKQRELr4YVi/kwttpeK90K
         doZnAyQJMSZfKODZfCGTHzPAAXrbQi3OgcQHkrEk7zsQnDB9/hdUKAuk4JcanYpc2wrT
         D2kHIx8gWe5e5V2MQrtNUBDDHmtAvu6J9SH8o1g+jQKWVWTxuccawDB4nqbS+gr+47IP
         mBiCDjR4s1YxO426c4b64VhFio3KDbThALZ16Ew3r4KD0qfnu/Rcm4MUjbuNp0B/QQOH
         WbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796346; x=1766401146;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFFtPLWt5GXwFQD6gQTfn7/fmcFvMDxSdb3CyQqoRRc=;
        b=cMpQ3RSFokReJ6+IK6iIU8AVJrpNg7T0uw5a6KWmkRfLgVy4pDMPb+DZ7jB5aplFl8
         Z2uKiZAWQp42GK29m/fVOP4DGta46qGMn8hHQBiEh02LNzvsy+DLEM/UDrfP5kmaN6sH
         zGfY41iPzHOx2SApEExviNKgDFhU35UWVOOt3l4UWfUCb02lwdkw7Bi0DQTB0oeOZyXA
         g4uqtz9l716fLJrWIeshQCppmtiwDNCCe5RdAV6kW8onPzBQ8Er5eM0zkLws1p6RdXpM
         +TjlOKHs61qJKxbHgJA7KCfsgFuf1Q1NmIGpX3FkDtpB9D/JyZzLruSDsxpOaa8QCJub
         2/yA==
X-Forwarded-Encrypted: i=1; AJvYcCXvesYzlhB0LNoLlPYzboFaUPl3DJ27GhMOix5vIEbFGJHaw0y5taoz3AiR1SC6XUUMYAb83+HDGGw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiYnSkW3yvJ8JNH1nz+TkRX/W2qM8BZpDDcjW/PKqlXMjV2I4M
	91ZmRBST6uCCYiuecuyfKMoypE51MVRmNJhlTON5NjYAt/yUiaI88jBg
X-Gm-Gg: AY/fxX5nTT07RKROEkmIo9b1aZFn2cd8+KdsBiTY240xBymzEvGkCQ12MHz9Y4CZaKs
	Ao6342oQkwVS9OvJGRxX75RuLbWnLa5X9wauHRkipIa4jJI2j7uEbFrlNtnJCHa/cG3mqrvtaC4
	RbqhWzyTz/6bNywDwvcef+U4/F3Ftp0VluAlTWv5BrHGfgXbapMekhWj3Ktfj6ENRTWPM9to+4M
	FTL0uD9hgyquHIsU9RUvz4mYdLvetuEV84mZW6VYsgJXYWzB5JaEI1BXcnuZ9ES/DGfgHuYthLa
	n2UgAMBo+mPEK74Wyz1QH0ZH2rbOG0q2kKhRDavo/CzXyo2D8kziyuJmAjBeYNvft5h6CsR2IIQ
	pNirRkEbCKOhaZzi5Z/5W+OkQkD1lB6G46tIC6biaZY1PD9qoIlIKRZyTEgTFVf7jzqz6PuEPAQ
	W3qizvKmt+K61bX/WCl2NOLLU=
X-Google-Smtp-Source: AGHT+IFaWJrWyBE9GIVvce2XyPwUKqAlGkmLp8oPaVrPoTGxqsS9OcEy2fJ4pY8O1VJB9+e56d6ihA==
X-Received: by 2002:a05:600c:8b6d:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-47a8f914528mr96729885e9.37.1765796346286;
        Mon, 15 Dec 2025 02:59:06 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:c497:8f2f:d889:ca1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm178004835e9.3.2025.12.15.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:59:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>,  linux-pm@vger.kernel.org,
  sched-ext@lists.linux.dev,  Jakub Kicinski <kuba@kernel.org>,  Network
 Development <netdev@vger.kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
In-Reply-To: <5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
Date: Mon, 15 Dec 2025 10:51:01 +0000
Message-ID: <m25xa8qaqy.fsf@gmail.com>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
	<5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Changwoo Min <changwoo@igalia.com> writes:

> Hi Donald,
>
> Thanks for the feedback. I rearranged a paragraph in the original email
> for easier reply.
>
> On 12/12/25 00:54, Donald Hunter wrote:
>> Hi,
>>
>> I guess the patch series was never cced to netdev or the YNL
>> maintainers so this is my first opportunity to review it.
>>
>
> You are right. I think I ran get_maintainer.pl only before adding
> em.yaml. That's my bad.
>
>> I just spotted the new em.yaml YNL spec that got merged in
>> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
>> because it introduced new yamllint reports:
>> make -C tools/net/ynl/ lint
>> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
>> yamllint ../../../Documentation/netlink/specs
>> ../../../Documentation/netlink/specs/em.yaml
>>    3:1       warning  missing document start "---"  (document-start)
>>    107:13    error    wrong indentation: expected 10 but found 12  (indentation)
>>
>
> I will fix these lint warnings. Besides fixing those warnings, it would
> be useful to mention running lint somewhere. If there is a general
> guideline for adding a new netlink YAML, I will revise it in a separate
> patch.

I have a patch ready for the next merge window that adds a lint target.
For now you can run:

yamllint Documentation/netlink/specs

You're right, we don't have a guide for adding new netlink YAML but
that's something I should add to the series I have pending.

Thanks,
Donald.
