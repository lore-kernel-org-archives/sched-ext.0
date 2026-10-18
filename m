Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227C3A5E6F;
	Sun, 18 Oct 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311362; cv=none; b=ZmZKVe/V+oHfvmoTwt/Hp6ajwns1JrHA4UFcYZHLd3FlMTwbbsSbpcVQoersmgcre19ZJrFIayB5ZpuWaDZejwQKUswYVNoJGalzViZe+psUg69dosoh+f7FTfvPU//k+AYHw9dkwWFUs7mrzAYL5S0UuVn6XkmDmkLPCsarDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311362; c=relaxed/simple;
	bh=QuJRHnb2bQUlxOhxjd2d1R6J+j5fq43zPSPFaBVpYTk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AZK/sPr1Wi8Agt9mXN6YVyIaL3pCzoE9f/wzLGfdqSOu1J5FWUeoLiLcYnkAILM3nscn5uIwBJYwPQJChwYqVDU8Wx1DpgrgL4JDJe7UCBOd1YJVg/V6S9/U/XdJTbdvskYpY8p0ClS41ZKUb34Uah3VfyNxr9cVUJWonPk7s20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjjd6ugx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjjd6ugx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BE1F000C5;
	Sun, 18 Oct 2026 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792311361;
	bh=QuJRHnb2bQUlxOhxjd2d1R6J+j5fq43zPSPFaBVpYTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hjjd6ugxnWecCNR8CB7E+pRf0/eMNOKFX8w7M/27XjsCBvMA+Vobi49xGS4tkmigd
	 sQZb670OuYoBRdjPeSAkVbUTsFE9ca4o7S1fWKgGDbcYryxV+sInz2NZyqZnaQYt3B
	 RNc+Zyp63QWWCeALqeWqtdxscOcoR8ogvSyEGqXrJfimkoCnWyxP6v/9Alh6jNi/SD
	 R/iais4zpD9b5t7A+wPxvSrSSdUYiJCPmoZrM4AJiGwfVLxqWNaTmKq2i9uUrf3QMN
	 aQZXLFdOa5LFJZVa6wO+wSGFMDyRNXA6ez2EkXTtsl3Se2eoDQvWeN02r5N3IhAk3o
	 V9VcbP1IhEMxg==
Date: Sat, 17 Oct 2026 22:16:00 -1000
Message-ID: <b291e2b97ceef620c6330b13978da668@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes
 offline
In-Reply-To: <atRuvuRosQI4JJZu@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-6-tj@kernel.org>
 <atRuvuRosQI4JJZu@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Oct 18, 2026 at 09:01:18AM +0200, Andrea Righi wrote:
> With a root-only scheduler the walk skips the root and queues nothing, but
> resched_sync_ecaps() still runs on every online CPU, starting the ext_server and
> queueing the resched irq work for no reason. Can we do it only if something was
> actually queued?
...
> ame on the offline side: with no sub-sched nr is 0, but we still do
> update_rq_clock(), dl_server_start(&rq->ext_server) and the irq work on a CPU
> that's going down and the ext_server stays enqueued there until
> sched_cpu_dying() stops it. How about:

These are on the cpu hotplug path, which is really cold, and the cost is a
resched on one cpu. It's minuscule and doesn't matter, so I don't think it
makes sense to add any complexity to avoid it.

Thanks.

--
tejun
