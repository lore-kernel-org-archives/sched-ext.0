Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD73F54A4;
	Wed, 29 Apr 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466853; cv=none; b=bMybaPnjf1/WAyeqj7gkiu7MXrbF6oC3Q9/EfL12ZYnGKwADYtG9XSmxFdHIfpUAS44kpFChChwAAxUINN7jhJna5Wt7/rZbL1HdrU//xz4A2AnqEy12Ddk+awxUf6/WRVzt4cS9qlKMIukzwBbdH3a0jzRKn+uy/pqDjhIOvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466853; c=relaxed/simple;
	bh=fU/zq9iu6F6TDmvvysKu2WV8QmyEqmlHUpJjkbNUPxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCnh4s3FMLujnb6IeViUF3GoiCw6bXrFAi9WKfxSsJTB1nRpJ3KTuReh2kRjCl7Oxs6yAS5oS4VZ/VZyYy54M9a2TROIVhMqz3E3hOufx9o6cgnslMEUbrh0xa/kYcokp/Odp/WbCpqS/pv5BrF6oDVQuDmlYRmrZYYSLnZFAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WGu4uQx+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WGu4uQx+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/T8N9LcK2QJHr7hyMxO8re27o7vVU8+DHnI07q5pyrY=; b=WGu4uQx+XDJ9sArk27JJy6m1U6
	u1ietS36s6uroVT/L90WiaLU9sUebEQQCztIcfyFxCiYt+aF0TT4LEucUCB144LvNc7/6ikepuEpy
	B2dBuIR7RboQQD8aV6qtbl4nB+YVzCFGrS6yZo49UAnvpSKO7D/xSjK+72Wghmwu5kckvr1WDgvv9
	WcNnd9Ak5z/b3Z/x2LjkozSR59N74ZSD0Yw/b1RsWqTkKVvUQJS0gtBikOKT384zgCG+pSs1wuhvg
	hKSKV/3gpHVXaeasRZshPlhHgQluCpv1L7o0Z5hVATFJpf1tbNUu7FQ1jUlHTBe0AP3d8ba+nqk3n
	4hstIwAw==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wI4K1-003w5i-Sz; Wed, 29 Apr 2026 14:47:21 +0200
Message-ID: <3faf06dd-1175-4690-b97f-bb4e0b30566e@igalia.com>
Date: Wed, 29 Apr 2026 21:47:12 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] tools/sched_ext: scx_qmap: Port to cid-form
 struct_ops
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, Cheng-Yang Chou <yphbchou0911@gmail.com>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-17-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20260428203545.181052-17-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/29/26 5:35 AM, Tejun Heo wrote:
> /* @@ -1083,6 +1082,18 @@s32·BPF_STRUCT_OPS_SLEEPABLE(qmap_init) › › 
> return·-EINVAL; › } +› /*+› ·*·cid- 
> override·test·hook.·Must·run·before·anything·that·reads·the+› 
> ·*·cid·space·(scx_bpf_nr_cids,·cmask_init,·etc.).·On·invalid·input,+› 
> ·*·the·kfunc·calls·scx_error()·which·aborts·the·scheduler.+› ·*/+› 
> if·(cid_override_mode)·{+› › 
> scx_bpf_cid_override((const·s32·*)cid_override_cpu_to_cid,+› › › › 
> ·····cid_override_nr_cpus·*·sizeof(s32),+› › › › 
> ·····(const·s32·*)cid_override_shard_start,+› › › › 
> ·····cid_override_nr_shards·*·sizeof(s32));+› }+

This cause the following compilation error due to argument mismatch:

scx_qmap.bpf.c:1093:10: error: too many arguments to function call, 
expected 2, have 4
  1091 |                 scx_bpf_cid_override((const s32 
*)cid_override_cpu_to_cid,
       |                 ~~~~~~~~~~~~~~~~~~~~ 

  1092 |                                      cid_override_nr_cpus * 
sizeof(s32),
  1093 |                                      (const s32 
*)cid_override_shard_start,
       | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1094 |                                      cid_override_nr_shards * 
sizeof(s32));
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/changwoo/ws-multics69/dev/linux-tj/tools/sched_ext/include/scx/compat.bpf.h:130:20: 
note:
       'scx_bpf_cid_override' declared here 

   130 | static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, 
u32 cpu_to_cid__sz)
       |                    ^ 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The correct one should be as follows:

 > scx_bpf_cid_override((const·s32·*)cid_override_cpu_to_cid,+› › › ›
 > ·····cid_override_nr_cpus * sizeof(s32));

Reviewed-by: Changwoo Min <changwoo@igalia.com>
