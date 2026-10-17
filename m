Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB70384CED;
	Sat, 17 Oct 2026 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280613; cv=none; b=KEPeujOcMJCJR6+u8Xn0Zz+1mlMYxy8vh2HBSkrrwyCg5JLh2fpRIKHRKjCSBMjP8GFUTgLstPGo3xcHUsayHzhtfmc0+Jsy+LlzrGmtAkPZwEsElS/RtRg8zVfAInC91PaIWyfNTxHRaZTzdY58euI7BSosMyQDEV4FqGBD87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280613; c=relaxed/simple;
	bh=f+LPrf9HHiHxsOI2b8S3d3VzmrVtdHcc0gqBhHfIckk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TAYKFo2lBIlEVi9pvn+4XJOkIUorh0/RaRxcZPuLrOaRz/G/7iUUt23uVbzoG5x7Va0tMfD1tV2OnnnHFcaGlLk4O2yWJZ6oHBQV6SikmqZZ2Xr8TOPonYgrXggqNTkzbLRDr9KGA98zmgY6zO4LBMCPHS78/5pQa3aO17EWGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpEPFEoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpEPFEoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA071F000C4;
	Sat, 17 Oct 2026 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280612;
	bh=vjVSjFlEW7fpFHLCEcW20y4QgCqYqmbhTqRIxTbZgm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dpEPFEoWk8hkBwhaxVM70EiJrxtiZgJj0hnfbYyD4jx/k0mN9KzWMy0zMbh1HEf2r
	 SGLQ5kFdIdcDZicYm/MWySFnr5nBkNqS/F1tEAQn5PZ83PeTktICqo2GIT+UQUrZ4G
	 VBsj8hzRxIFaULKdDBSp5kaZFkNwH6xt0jHpCTaOc0d5Z/uvGrzp6tmuwnmUx4MtiW
	 8QA35CnktZqXGH4y/vCJ0y6I3cfdCykIwGu2kbpKwwqPoOXbCtyrUAruf0QifeR+Aj
	 Nn2Nk/1gmWc/ZTfxsrmkw8yJi/p353PXuTw6KCr8FvTwNnJBCiooDl70kR0955laYx
	 +Q97FdWdCnPUQ==
Date: Sat, 17 Oct 2026 13:43:31 -1000
Message-ID: <79fb573898f66c7a107514e87e16c68e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4] sched_ext: Add scx_bpf_dsq_reenq_task()
In-Reply-To: <20261017223738.993262-1-tj@kernel.org>
References: <20261017223738.993262-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Sat, Oct 17, 2026 at 12:37:35PM -1000, Tejun Heo wrote:
>  0001 sched_ext: Factor out the rq lock switch of scx_dsq_move()
>  0002 sched_ext: Add scx_bpf_dsq_reenq_task() to re-enqueue single tasks from a DSQ iteration
>  0003 sched_ext: scx_qmap: Also re-enqueue stranded tasks with scx_bpf_dsq_reenq_task()

Applied 1-3 to sched_ext/for-7.4 with the following changes:

- 2 is the v2 posted as a reply to the original.
- Added to 1 and 3:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
