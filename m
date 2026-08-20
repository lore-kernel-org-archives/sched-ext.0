Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AA35C6BA
	for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236359; cv=none; b=ITFxNdx/sbgAyCaGjgTMrWe7i3BItKVG0xB2Dj6M5Q3TAQti4Afsw1tczOrDiiLLr5QYlDK7eTqo27cCF37gq9lz4IQADpA8+oDrLik03o1ePItCMqboSTvKubwmGCrqX7mefmUm00wugS9KHxcaP/AeZwoJdC+WxAHBiJTLEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236359; c=relaxed/simple;
	bh=5kZRqOhgJuG9B/HE8Ph/4js4rgGVTxAXy3MOWKyr5l8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qYOrPltGmjRyMYTAVIUp4Y56W29HDofLkHL9Crq/D94MzgtfpxdC/X7RSDvDy7lqfX7RHRgm4aDCd6s8BWbozwVEbSEIttl5cyOZRTLZg9fV+yAXuAjFAHQavfv339ASJixDa6j/NZCzqeMf2VUZhilUwx748oq9sTaB2zeIj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzZmMTOk; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzZmMTOk"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c16060ba9ecso22269766b.0
        for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236356; x=1787841156; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5kZRqOhgJuG9B/HE8Ph/4js4rgGVTxAXy3MOWKyr5l8=;
        b=FzZmMTOk1ymUzsuu4JiyRsqWYuQt39aMQ+7W0Ep8fVwKfNC7mFELb0kt1AHB6ZcbSp
         5e4cOrM3h6KC76sBDj9/kX21t7qkjuHdxzX3h6cbP/LY3hM5IhHGQG+2sOQjtYbwgAoP
         AJxGXl3OEJs3BIewU3C90d7MS5Uiv/+EWCcRTGmaAZsKet645W1eb6ll+xlNn/q7ttu3
         46VYU47BjkDg+vx7BeLzSd36JC81piy2ZQKupt+p20ZxIpSoZJsz+aN9d/nM4o7M/Mtz
         b0U+UeD4UFX80IZvtQW/oQ/QEu0esvbBZxnngHjzRbaSmmmWYd0DC3cw+6d5u0162fhj
         96Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236356; x=1787841156;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kZRqOhgJuG9B/HE8Ph/4js4rgGVTxAXy3MOWKyr5l8=;
        b=op2jK4F3uuX8KNApePr4PyehccjKPSOMDUZhwwvYVtyAI6mOmKPmelT818UNRxCEQn
         LtCuYTtgLxybyE/WcCxxBr7sJTmVsLcf1IwHHjmi3MINRBSp4Xhp1GlOUJZDGjQsXwW9
         vJRFQixT2FMrbKQ/iXWqpJFRVBP3QPwCDdmHSs6hWQE47jI9DsHcDdWtR3+qMBDKJBGj
         LHEUIMGiGDTPQlhg4AuPwOgrskmmyONx3kUsSGY6g28QXdxayBjaB2o7H56/SmuSIxIf
         NllBrxdZAoRoK25JVoFO7dMFJv3GFdxAWe9itlTpCn9Xd4LFNP6Qk39Djc16xhEQvdg0
         N0Cg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3nFLl995mrIgaVlQnMfYKUDCyayD/j8PyLE9QXwhH0zcwIQBwSOhn5b+HFToXLLy1NZ4+KVNFAuw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTxnIRt6PKJ7P+mXaMpkIZQDhZnHX679F2LIG+s5MNmDuaF1VD
	UgdNgHhNB7iEmZLeNjlVie6nBQl7eaahVefDzjyvry+yWPtV/kv6cfJe
X-Gm-Gg: AR+sD11efbAysalHd823Oh2PblZlTmXq1beIjb6nFr/HstlQN1QCsIGHHqst26XytxP
	Ld4YaoZuz2UsBzPGD1jc5p6IPEknItvp4f5YAcpf3umnXbcFL2XUIhdumnO3co6xuHNhoTnHPzC
	2o7KeYmUZixcsy5RvQu0DACvlHSgV5XGM8GqqKSCU6oGLHlXZNFDtZFrmqkacUZAVsmc/c8tLt4
	hF5rODXf70TfPIOuk6DaWmJZP6+8KLT3c7EwgsHZUD9KUaufjQmMZkt+JWo1bt3uNIyaKbO8vmn
	pPgpteX23o5PIezHdpMw0ZnT0wTMXHkrzYo2grr3RU+19qiYHcxDHd31uWnsfSB14elDbcxL5ND
	NFnF751mUrIxlzQzIk2dtaZPNk71tFTja/rlUpey+7fs4MSNgQjigui3AKrOB8pcl146A+5yRID
	s1+/FruuG0WAd8D1JP3K8++vXKpk7kddIj3wX/LlBE32K858nB0DtlIIbuIBbB8GKOafxsyhEgj
	6GPGcJTxqlofKOYKGD/WLHKXxMjOkQ0en+cVkgOCSa7AIv2BrFrrg0oyL+8+qADESG811TDvuWQ
	pwpetE7lUdG50RxB1ANE7nUVcr8=
X-Received: by 2002:a17:907:a703:b0:c21:4698:ee9e with SMTP id a640c23a62f3a-c244d51f63cmr580971366b.7.1787236355670;
        Thu, 20 Aug 2026 07:32:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df465sm77222066b.48.2026.08.20.07.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 16:32:34 +0200
Message-Id: <DKTUEUJ343P7.2ULJ2RYGV6XZZ@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "John Fastabend" <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: sched_ext: Mark ops argument container
 pointer fields as trusted
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0
References: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
In-Reply-To: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>

On Thu Aug 20, 2026 at 7:20 AM CEST, Tejun Heo wrote:
> Walking an unannotated pointer field of a trusted struct yields a bare
> PTR_TO_BTF_ID in non-sleepable programs, which kfuncs and helpers accept,
> but PTR_UNTRUSTED in sleepable programs, which they reject. This gets in =
the
> way of making ops.init_task() sleepable, which schedulers want for
> allocations. For example, passing args->cgroup into bpf_cgrp_storage_get(=
)
> then fails verification and the only recourse is round-tripping through t=
he
> cgroup ID with bpf_cgroup_from_id().
>
> The pointer fields in the sched_ext ops argument containers are all pinne=
d
> by the callers for the duration of the ops calls and are never NULL. Add
> them to the verifier's trusted-fields whitelist so that they are PTR_TRUS=
TED
> in both sleepable and non-sleepable programs.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I (or others) will add Fixes tag when applying, no need to respin.

> [...]
