Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6D199FAB
	for <sched-ext@lists.linux.dev>; Tue, 30 Dec 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099399; cv=none; b=VqXCd1ZBsfzezFCvd6mlEG/A4HGKntn7MJI0kq2DPh6ZW8+HdaH10C/bBy/AneN4EtBnVmhdQd9cTBPaCB8vLZKj1bruTR6NIV/BGjpqQNeRNm8MvYBAd2uHtR5ESl4HWVSlSjTFFmTghcnkUZPPGbcK+2iRQrGSj27Rpfh9uCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099399; c=relaxed/simple;
	bh=qA+Llm8/LCWJPs0YBfi84Z6KAfPrxe6ryFR18gOX7Lo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=p5xq2tXkzF6+klGP7ssJAxN2OFr0dSTIrENTQHC5CeGNEltA3XtLAX3W3mWhQ71YU2SgnOw5TJy38ICpDXDtHuOzDXIbvQzXxuoj9C4XjjHehjAORFRQ0Yq1RJhQRHEihc6QozUrncHfdBNM1DVkMJ1sd8SoBTFqk1ztrbF5TTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZLvF/yX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZLvF/yX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775895d69cso41761995e9.0
        for <sched-ext@lists.linux.dev>; Tue, 30 Dec 2025 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767099396; x=1767704196; darn=lists.linux.dev;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1g1kb/JOi9XsJPGmGm57a9CaF95ijegnXyJMo6Mx7xQ=;
        b=VZLvF/yXhSRFGRCl6iaop//XquWLMFxrgNYSoG63yHGjmIaM0kAIdCwBZzhfE76JLW
         b2cPOj+KRN0wxKe4LlDsvp1Ib1+Eu1rM/GQX7J8ODyfN5eUrr+6ObufvEP+fmzT8lJj8
         /UZq1gzi7DdhxiUqSp6N+iWbEQXnKOwWNv0pGoe/vJWqjMXsBBKKcv8u4Vxjwt3gvnhJ
         mt3uPbsMIcxK4G+OGAqpQUkjRIk1HNBlQuRYYIudzZ03oD8FNWoMSMzWJwh9ZSSCTfvN
         IYII1dAYD96Zi/yhHyz2WbkmRy22Om/+/vAR7+e3jx4fayb8DnFulP9ydhQQYj90rjsw
         m+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767099396; x=1767704196;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1g1kb/JOi9XsJPGmGm57a9CaF95ijegnXyJMo6Mx7xQ=;
        b=Lt3+1eN0yrqZYQJub14RGl9msYDbm8ebiqgolh+lxQFnfOrG68MrIXGHmQqbRHqW5n
         qI49U+O5P8xkunnOyR1v6ezsuLQeekSXs3PygZTpgwFXW7BQXM/mlSnpWbnRPlaxfj6T
         fEaHcjEa6938OfSDBHlTqe+EV9ITl+mVFuz/JRp1eRKCR9LT/XwBO3RRz1edPMCf1zTz
         YsiLNBhRKcOwS3jvDTx3YFCzjvQ+a+sIoFBp+P/CaTWY8iHVPeX7MIAoVYp/77Xiy7xH
         dT4ywExUoguiRCartpap/JY30i6pE8uS6RsED/hrel+v4/1mztcJgX3o9ancn8/pc5VQ
         +hlg==
X-Forwarded-Encrypted: i=1; AJvYcCUqrbSPi32jJkNS7w40Joc0WdAt+XtTlEnWH2kFcjas4lKO+OKNEfhZdi9H2TuU/YvtS/mOT+A4f44=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/W0fmoC8fudhbj1qz4739ILioJrZoMignd6lUvIHIyRmi6tDe
	lx9cBgBp0n/TR8gt6j3vRrx9B7oC+zS1Re3DqbHVBH4iju8l0Woc5LaI
X-Gm-Gg: AY/fxX5KTT8eWwmdLHRE15ML/Z+t+YRnFKkKClB5yyUDcvQwk698Dshu27g8LAPGEb1
	v6b8BY2lPVs/kb+s2P2RunTfpzY3DrVPNhHFI2D5yjQl88ij+qoDBP8sIHDsVgmMDRq2V47H6yo
	Y8mQzK4n0pKNtos+ltUyA7xYR1sR45kWMy1i3fKB9ln2HoWZtV+b/MJCIU9tM406DVCTw+nDwa9
	ULDTJtMfbswgIBwd0U7jUhqnjAZjGrJPALpZez7sKEVTU7TMKeTETL2echvnLiVhMp1qawElml9
	8rud8LowEavdhmcVxer8FCAaJvbTmiCMW9TOuBv+gvMeYjLvB7Ln4HK+gSxpjp48HT9imYqMS8W
	WA0pV5Mj+/qkXVSBfqftaSDVwfG6h4iJCaS7hGWQRA0eZ9PFDkDJtByaqSNJ6VcME93LmMNQLtX
	iTBBxQY5QOcENTj8SW+m3ejv1mCo9JQwPSK0XPUVm6Rw3X
X-Google-Smtp-Source: AGHT+IGXIOQiYhgHUXu3tLRwuadO2gEnm0hRaSS+QlqjvGD/CbRO6q8KjLwpAqdJ7Xfc/tDhstFhvg==
X-Received: by 2002:a05:600c:8b06:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47d3b011b03mr234735265e9.19.1767099396343;
        Tue, 30 Dec 2025 04:56:36 -0800 (PST)
Received: from smtpclient.apple ([2a02:8010:60a0:0:7880:449e:4715:b158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm578531675e9.2.2025.12.30.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 04:56:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Donald Hunter <donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH for 6.19 0/4] Revise the EM YNL spec to be clearer
Date: Tue, 30 Dec 2025 12:56:25 +0000
Message-Id: <BA1D25E0-F4D8-4FFA-92AA-FE58FB3622C1@gmail.com>
References: <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
Cc: Changwoo Min <changwoo@igalia.com>, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 rafael@kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 davem@davemloft.net, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 lenb@kernel.org, pavel@kernel.org, kuba@kernel.org
In-Reply-To: <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
To: Lukasz Luba <lukasz.luba@arm.com>
X-Mailer: iPhone Mail (23D5089e)



> On 30 Dec 2025, at 09:44, Lukasz Luba <lukasz.luba@arm.com> wrote:
>=20
> =EF=BB=BFHi Changwoo,
>=20
>> On 12/25/25 04:01, Changwoo Min wrote:
>> This patch set addresses all the concerns raised at [1] to make the EM YN=
L spec
>> clearer. It includes the following changes:
>> - Fix the lint errors (1/4).
>> - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymodel=
=E2=80=9D was used
>>   instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was originally p=
roposed [2], because
>>   the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, d=
ocs
>>   strings and flags attributes were added.
>> - Change cpus' type from string to u64 array of CPU ids (3/4).
>> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch=

>>   either information about a specific performance domain with do or infor=
mation
>>   about all performance domains with dump.
>> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for exampl=
e,
>> with the following commands:
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --dump get-perf-domains
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --do get-perf-domains --json '{"perf-domain-id": 0}'
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --do get-perf-table --json '{"perf-domain-id": 0}'
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --subscribe event  --sleep 10
>> [1] https://lore.kernel.org/lkml/CAD4GDZy-aeWsiY=3D-ATr+Y4PzhMX71DFd_mmdM=
k4rxn3YG8U5GA@mail.gmail.com/
>> [2] https://lore.kernel.org/lkml/CAJZ5v0gpYQwC=3D1piaX-PNoyeoYJ7uw=3DDtAG=
dTVEXAsi4bnSdbA@mail.gmail.com/
>=20
> My apologies, I've missed those conversations (not the best season).
>=20
> So what would be the procedure here for the review?
> Could Folks from netlink help here?

I will review, hopefully later today.=20

What hardware can it be tested on?

> I will do my bit for the EM related stuff (to double-check them).
>=20
> Regards,
> Lukasz
