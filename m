Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9E2BEC34
	for <sched-ext@lists.linux.dev>; Thu, 25 Jun 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419304; cv=none; b=ppPRl6N+agOs513DmAXeksKp6qLB3GlMb0bUndT2FPwaG5yhnfzCThJodma+V9qnpzJOWS8ZQBdpgEltUy9f9pYOaG9GvtX2QkqXhKSdIE4xr0OqfqXhuKytQ9Rr011UCayFTd2jEzRc7lLNUqAlBhpSG1YHkXsZ/t+IenlMhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419304; c=relaxed/simple;
	bh=zsB6ddbjvxM0aL0SNi15EPb6fX8+Erp4wtUB6a2tEVM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TArm5QgN7Bo7wW880fcKNGbnGvuA2LP9grezpjlsssaHrZzKO31581kU7lJlFuMueuI4yp/Hmrxvi99J/HLcUVLnLVbZjxvGa/qCifwNvkvBzEeqCW/clgPRtoR6nsbiTsaEMCDxd+MrobTuhUVjr202jnPlzuC3sjDqEjthXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBUk0G9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBUk0G9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D651F000E9;
	Thu, 25 Jun 2026 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782419302;
	bh=zsB6ddbjvxM0aL0SNi15EPb6fX8+Erp4wtUB6a2tEVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fBUk0G9HG7r8Aav4BRctrt85w09mviZRhII7LN1+DS3VNwpLE2bM2UiJ1RrL4ZL4w
	 nk1UMK+xNfMButeGuBdJm9jKL5L7cqORfzBhTe+jPg0PYTuuyFSFxz5soP+Gj9toxW
	 cRodRJybp0wli//rAmk2o8K5LyvkVCIfEfalqhiD59MhtM8UHLfSSpuxHEV64tl5tU
	 TkzjabSQHBZTj5geuWNL/+/uUJAv0GrfuD8SGbCpRLwJ4oxegd1Xc0hiOXNWGx11Es
	 PUn0uw7G2Sy+3aS+pIMnaymvYXxJ3eLWfha+lHjAOR3RTf24+aA20yxLq5Erpj1w2A
	 hoiGws+wJV/CA==
Date: Thu, 25 Jun 2026 10:28:21 -1000
Message-ID: <9824aa26635ed88b755a32156116d575@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.2-fixes] sched_ext: Convert
 scx_arena_grow() to use scx_arena_to_kaddr()
In-Reply-To: <20260625151324.27505-1-yphbchou0911@gmail.com>
References: <20260625151324.27505-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Thu, Jun 25, 2026 at 11:13:11PM +0800, Cheng-Yang Chou wrote:
> scx_arena_grow() was left open-coded when 2e05f2fd0dd7 ("sched_ext: Add
> scx_arena_to_kaddr() / scx_kaddr_to_arena()") introduced the helper.
> Replace the manual bpf_arena_map_kern_vm_start() fetch and #ifdef guard
> with scx_arena_to_kaddr(sch, p).

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
