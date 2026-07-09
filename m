Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5F3E3158;
	Thu,  9 Jul 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636131; cv=none; b=YEwBL/gwq5KhfhhM0gz5hME3QpqrMUnl7RB2E3t8fvGr9TqNPGIatsDF1+SqRZKO7Wf8gbUHjC2aUhvI+1zFvdxOoTASX6KYeWsaPALOQkgtBWV5l85sjQNJJbQVMvmSYuPrCJbkk1xIMl2JWIBqFIMNoL/cXOch9CnhtDl0L0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636131; c=relaxed/simple;
	bh=fb3oqqYj+NW2bDBboLS63URiyfp1LWbJxQiy073BxmA=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=F/C3x+gSIdSiCJovi/9b49haeWWGXmUcFfYd5jcY6pyDHVeVyomNDb23IJGC/lWjXYn2icrJ9UGJX+MOSbM7ANKqYj8st9nRjhhA87jO90EdIUVUJ4ejEYkFhtsjZB9M5lBr/RZXA2dN6eHGWx/zbXnMWKLNOGHZGna55Z0Somw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7KSfltx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7KSfltx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEA81F00A3A;
	Thu,  9 Jul 2026 22:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636128;
	bh=oonzcVW4aPIapWr0wavOyDqlJmJDlSEGQNLPawd4Djs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=R7KSfltxe9TkmYm0xWvcHXTHAmw5HkuyON1OrdWosPdtMe/MIbiGHw66HJk0v+EAZ
	 b0FmDFkcX0a6plREtiTud7fBvH/cQzEcFQvPgG+BSIBLeKWfkdPm7uLUBW+VG4fc7I
	 wUWh1jp3/nQHYLcOXrhe6JJ8V1vj307xazilhThEiNCGyUiAZ558MgU3DA8Ub8yo9n
	 9sjPZZWj9qqIbbP810tHMDsy7d2/tYEACweEsdY00m1m8QIFD3ZdDR7iyee+RnG37A
	 buXR1iKjADRPa3P8+MCXzaAgV0jHzxbFOTvFgtekSYKThGSOAyW5WJ54OOkFC2vNOO
	 FFMMtPvt3ycIg==
Date: Thu, 09 Jul 2026 12:28:48 -1000
Message-ID: <a4a849deefa9a512aef329245c1f34bc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708220353.392CD1F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-40-tj@kernel.org> <20260708220353.392CD1F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 39/40] tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:03:52 +0000, sashiko-bot@kernel.org wrote:

1. Not reachable in qmap contexts - the cid table is populated for every
   possible cpu before a scheduler can run, so scx_bpf_task_cid() never
   returns negative once the callbacks fire. The cmask helpers also take
   u32 and bounds-check, so even a negative would fail the range test
   rather than access memory. No change.

2. Real policy nit - fixed in v5 by masking the highpri target pick with
   self_cids. Kernel-side enforcement is copy-down by design (an ancestor
   keeps its caps on delegated cids), so exclusivity is the demo's own
   policy to enforce.

3. Benign - a stale or zeroed id just makes scx_bpf_sub_dispatch() miss
   the hash lookup and return false, a wasted no-op call at worst. v5
   reads the id once into a local anyway.

4. Same as the v3 round - self-healing, the fields are re-derived by the
   following redistribute() and the clean lock can't wrap the cmask ops
   as they call kfuncs:

     https://lore.kernel.org/r/d0ae1c17ef35bc81e5a36e4be4ca2f07@kernel.org

5. Known tolerated nit - the weight is advisory and self-corrects on the
   next pass. v5 adds a comment noting it.

Thanks.

-- 
tejun
