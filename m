Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542859;
	b=Kdv9tKWUid09Zteu7on1+ipBbB+S/4SGUySgd+jA6htzor6O+Rn0cgA8TzxUBbUFZCQx
	 cvd+ojxU9fCKjriHsQ2UEDQ4qfhjMMF+AZqKoCSNzD7d62p6dA1YF7RDSyMlX7lMGvZ3P
	 jB4z5o1FJcnSRCHTiZggFTlPzZ3IXi3X26ZXvyXx6URbeIAf0VvxGCMjL9D7EDFMo3Ggp
	 eufTY67Uo8wgz3SS22cXR69h1oPjoUygJYujeeShSUSPW18Iz/znZgXpWiZ/k5pQMNdKk
	 sdFI04e50XMSNGQONskOwmI10rmAyLkVSJdBN7j3sLoByyqsBHoeaTtNQe9tn5BwUvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542859;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=URjcWFFmaQz9JzFhkAeN4Frd2qPoCJDSemfggDPbALI=;
	b=dD1OPeqlYXd9OWDa3YyP1OQBVqPHgfgptV0uuu8NuBYi7Mf9b73VXINT6feXRwcFJ6iW
	 VE5LHzEZwUI0hP7ebH8wDTe0GIe96dWmLNHWppqm89DAHr+txoSvI2AI4TNoURQCwUL1c
	 Xqfc3G0m0bDVrwBdZY7OG8WTeZxCxsMIkDu5svXZcOtC1nfamqRvA065tYY4hH58mvXku
	 KnvzkjCFwnAiW3yS1T0E/mJpLfwjGopX7qhwE+p9KRLF67ZMHLoxJTbPoWYv3iGgG1l+O
	 k2bT94FF0i5FyupcKgiyvLBYN6laSaN4jlETwVA9mHs+puDUXLkjijaAyPzzDfr0KCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lh+5Wx9z;
	arc=none smtp.remote-ip=95.215.58.119
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C7606A323
	for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 04:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2C7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lh+5Wx9z
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=WOR7k447wuym28T+VI83MiZCHdDAluAll1lu5BCwOYk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794542855; v=1; x=1795147655;
 b=lh+5Wx9zqLFj+ASf4/F0EYXl7iurm2KL7BxNxHir87qOojq9SoWRR8J38Ikg9jRnuL6fHvLo
 90LdRDEpg3CUcSn7OcJSU6lpdZSUJ8N14ZvKpiKgsdKPpvn+dbQQ+N+wSqA3FTq9uzm+/3ZFgCH
 haFgQQZGW1zlhO8Sw0gK/oVY=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 65693a2ca75d0c4c;
	Fri, 13 Nov 2026 04:07:35 +0000
X-Mizu-Trace-ID: 65693a2ca75d0c4c
X-Migadu-Flow: FLOW_OUT
Message-ID: <2df669c7-d321-4cf3-8e04-250ad527a28c@linux.dev>
Date: Fri, 13 Nov 2026 12:07:19 +0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/6] sched_ext: fix kfunc, sub-sched, flatcg and idle-mask
 issues
To: Tejun Heo <tj@kernel.org>
References: <20261112130934.563321-1-cui.tao@linux.dev>
 <eb63bdf20dd6e2f09b0e7c81bc905878@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <eb63bdf20dd6e2f09b0e7c81bc905878@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/11/13 01:34, Tejun Heo 写道:
> Hello, Tao.
> 
> On Thu, Nov 12, 2026 at 09:09:28PM +0800, Tao Cui wrote:
>> This series fixes six issues in the sched_ext core, the scx_flatcg
>> example scheduler and the CID helpers. The core.c fixes travel as a
>> separate series.
> 
> There's one actual fix here (1/6) and the rest are rather vacuous. Can you
> please think more through each change and whether it makes sense in the
> context of actual usage? If these are coming from LLM scans, please don't
> just follow the details that they surface. It'd help to actually use the
> thing that you're producing patches for and think through the implications
> of the changes that you're suggesting.
> 

Thanks for the feedback.

I did use LLM as a development aid. Some of the patches started with
issues it identified.

I see your point. I focused too much on the issues and not enough on
whether the fixes made sense in the context of actual sched_ext
usage. I'll keep that in mind for future submissions.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

