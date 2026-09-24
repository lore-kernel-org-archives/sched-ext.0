Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF24A8FD9
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267423; cv=none; b=fpLuDA2YBbedmZC/5FcFmwycNt7ubMlZhJz+25zohSwpIJ5ynAh9+33GdQwZJN774A4NVIKoB8BnJztLeJL+FjMo3A/TVmRKdRzZoN2K3ptnmzf9fDjXcJ/v9HimBrW9sT5xu0amIAJew44AZ62hZfpu/js396rlLxCudfscaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267423; c=relaxed/simple;
	bh=73k6FJTz+3Iw7WPeGZfV2lzEAXI++hDZctysXJS34no=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=VQXDM8FGoqae8eSdj5Y0Y1HqfnihcgR3loMnO0W5d2kh5TdrGv6w9/EJtR1cIvpVTeoJNxv/lSz7JLkpoImlrM/FWfYN073blKVBy1+TkP9zCVnQUsq6NsGqlCXU3XGdRhqX+Dhz73reFlWqeD1A9umYilV5e3TvScXannYGZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqUHkwNH; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUHkwNH"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8288165fbso187707b3.0
        for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267421; x=1790872221; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73k6FJTz+3Iw7WPeGZfV2lzEAXI++hDZctysXJS34no=;
        b=ZqUHkwNHXIgDJPtIF0rJmVFQ1TZ948Bbh4OrzILwf2C7k+szzmrstSx8ITWh3nhT92
         aYNvin7RSmR3sOrzCYau92bEOR8DzfaRQrESL4fb8JCU/bEISWy4IOm55SQtiDi7pwN9
         IGnmAyyfayTR1x1YKh/r8kxq0uQGVlGrzqFV4nrZR0/Em8ytR2T+pQNywK286fgB30S6
         L83xeDjyfslYSY9G17hXT6wQbTTdt/zCZXOdkrh8nKxRMG2BepmKl4tKAkD/n6pYgdyf
         vUjNwG6fbA46dwDlp5RFs75b8KiwjAuYkN31ws4SYFHd4fadQB/DfjOyGpcWJ3/FbuTF
         1ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267421; x=1790872221;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73k6FJTz+3Iw7WPeGZfV2lzEAXI++hDZctysXJS34no=;
        b=i6xNs8fgaGunPBX5dEeaMvxh9ZDOgWuW0F8nBwP+MopTXYBOLxsW9k9X6VF5epUU2D
         1OIWgS2A8+tnAJSdL6nf47cX6T0DpJZ1ychamSdr6d56YFaju3//oIGglAxcqFDNjLgv
         Na3WN6Tcr+3dDVMCFJ7Tjq2vvzv0VgSwC25k2ZR6HOHL//mVGFJovVf06bpjzZFhQJBm
         01cugn1sTBgfx1Zi3E5Xwsgk3IGnj3giy2cHnQsX2C/DopjgDTX7PjnQAMPgTGS5qL3z
         F8NOYVXeump2+sVFbormaAQEaGBL2Zhi51vom0qmdkFdU47/itMt9rn6gZ44zdEuRHpc
         W1LA==
X-Forwarded-Encrypted: i=1; AKwUvBxaUG10uAh8xUVDuD8r/Ttu3kE+JMh/gjCf60wlW0I/DS1UsjdROcN/RJ6bhPz+zZP5LhGDtWqu2gQ=@lists.linux.dev
X-Gm-Message-State: AFuF++nLaD3H1hBT22cMpG7WkIFHPj9+hshClUz+X5Vef+bjcvv8vh5N
	J+q3M53kxoX8UcSs1GlC3pTVX2ywSNR6Vm5xtCoPYw8Elw5yEA6vCq14
X-Gm-Gg: AYBFou3OlMDksS4NZyWdNcfzzUBaFT7YUlRSzHZ1gBX+fDKD60JL1EmyaQSPbklMQcL
	HP6EckANwX4wrzNN7prY92Y1HZrdW9XCN9hUiBGy94Fk52uCw0EHb9N3jGL9jjRuUCH+zqGmJok
	32GK86415aVYkOzAjSKyycRErjkK4XqrZeqpmfnjpPetuoKdXQt1zp7p1EwTrC1G46CN2f5M03L
	vhLyvLBWCJNP+FrnqIKsOw8TtRdD6SUIi4tCc539tIvtFuABsYOav/c8SWnzPkoAvCFAwYwWs73
	jjf2zXFkZEDFbq7ejLW1kGVS8HbM8I4ew/hjdWCWwKb6RE6ZcD5QLRg9fXypAkie7hcklWQFuxB
	ZEB4/f0+aV0AoeU5ykF39dIBu3JEz5z5MHymnpo9yRaKeKzwOohCXlqIYP0aiX6pHrKyqWsoFUB
	guiodJGs/ILCl0e+uSZme3NsqWh9FE8fFUNnC6PHZRRuig1J6O+BNN+UzCXCrvCnEectIIpWl30
	E4eNC8lj5avEOJfPRolAroGvU+SjJHfaS0kCdFYQfsYUccvMFDsmG8MG3vtSw4c+BsGKPR99xPI
	rVKn
X-Received: by 2002:a05:690c:e3cb:b0:8a0:9ec0:e13b with SMTP id 00721157ae682-8a648ec5183mr21164237b3.17.1790267419358;
        Thu, 24 Sep 2026 09:30:19 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a6525dc675sm10883477b3.34.2026.09.24.09.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:30:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:30:16 +0000
Message-Id: <DLNOU1DBG2W4.1SHS4ZHDHYUM3@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/3] sched_ext: Stop citing the x86 JIT for
 the cmask cmpxchg loop
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20260924160354.531101-4-puranjay@kernel.org>
References: <20260924160354.531101-1-puranjay@kernel.org> <20260924160354.531101-4-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 09:03 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> - * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
> - * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
> - * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
> - * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
> + * Not every BPF JIT accepts BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on
> + * arena pointers: arm64 without LSE rejects every arena read-modify-write
> + * atomic. Implement test_and_{set,clear} and the atomic set/clear via a
> + * cmpxchg loop so this works everywhere.

arm64 without LSE rejects BPF_CMPXCHG in arena too.
bpf_jit_supports_insn() there returns false for everything that
is not load_acq/store_rel, so the loop doesn't load on such cpu either.
riscv without Zacas is the other way around. It rejects arena cmpxchg
and accepts fetching and/or.
So the loop doesn't make it work everywhere.

After patch 1 can cmask_set/clear/test_and_set/test_and_clear
be __sync_fetch_and_or/and and CMASK_CAS_TRIES go away ?

pw-bot: cr
