Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BA4457BE;
	Wed, 22 Jul 2026 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745792; cv=none; b=IDUOJgav2jIvEvBy5aZpgRhUa2Cj7JeUGnHZF2uBeDJNO8xQZp9qnjO7L0hoOP6C1TqUwB4SvVGBbceUjvP21O127Bw4lLDtTveY/pnV4vc6HtDwQiaJM7dm08jqd2JZjZyimYDxbiR3/s14chz3bl2dU4JpdgTwA6UDwiBqZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745792; c=relaxed/simple;
	bh=I7OAPFVw1qwfP4L15Bcyym54Fr9eyVz6y1aErBbwV1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm5sPxB++64w3UzP9+NOF0g+NPNUskVK4H0+4cnFF2eXLpVDfh2VkxdQjbRPH7jz2mJJFwhOS9/VzTz3tDaySHcKz42TSNLyNlqYrJm/YH0OizvdayAoG3QIc5g+Pf1Wb8JEpmzh9gSeNdXEveTN+PNo7puQi7HUO9UifrUyD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BsgpXMd+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BsgpXMd+"
Message-ID: <f83b6c93-b32e-434a-94b7-68628a2e8527@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784745786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU7TNupb0pdhQBzs77sfqtrZ1+d4xoAeYWx+j3QiA1A=;
	b=BsgpXMd+bM/LhQJ2Rz7ftetxHEMGudfLcMl4EwXOOefgsqqUA+QfxR2ssFJp4BuLLOtnV8
	wr0DW6Ha7NOne5YliUKnWr4ctzX7Wb4TOO9wzA1gl/rTqa474oUAM576CKQ0vhO6rpIyJr
	lWH6SLT6mICi3YJyQVJ+jlD9UymTRoA=
Date: Wed, 22 Jul 2026 11:42:58 -0700
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] selftests/cgroup: add memcg_stat_cross_cpu
 correctness test for flush
To: Ziyang Men <ziyang.meme@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 David Vernet <void@manifault.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Mykola Lysenko
 <mykolal@meta.com>, Nathan Chancellor <nathan@kernel.org>,
 linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev, linux-mm@kvack.org,
 kernel-team@meta.com, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260721174833.1232771-1-ziyang.meme@gmail.com>
 <20260721174833.1232771-3-ziyang.meme@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <20260721174833.1232771-3-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/21/26 10:48 AM, Ziyang Men wrote:
> Add a test_progs selftest that verifies the memory-cgroup BPF kfuncs
> return values that agree with what userspace reads from cgroupfs, across
> a whole cgroup subtree that has been charged on many CPUs.
>
> It complements the existing cgroup_iter_memcg test.  cgroup_iter_memcg
> calls the memcg kfuncs on a single cgroup (BPF_CGROUP_ITER_SELF_ONLY) and
> only asserts each value is greater than zero, so it never checks that a
> value is actually correct.  This test compares the kfunc values against
> what userspace reads from memory.stat, and checks every node in the
> cgroup tree.
>
Can you extend the existing test instead of adding a new one?
