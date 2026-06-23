Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBF347FC8;
	Tue, 23 Jun 2026 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201196; cv=none; b=KEBrMklplhcBcZ+5EPpgnIv9PjnL/sWDeIKYRWW6+91W5yPVLpyQ6mc7b2p6hNMOFyx2DpH2ar7BVZB85xo1i2qnD6ZZrxCBJ7++T/kGhSeMgmqX3/ih4tsfjrLX3578RU8THYQAuW21PW4oWpouv1gtaRgAk4C7R/oEchf2ZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201196; c=relaxed/simple;
	bh=nh8P3PWPqMfa7kVs/VTDphL9R49dtEAnLvL7b9GvZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyPNkgedOduxsxVCr7GBpt+IJcZj7RIwE3QdcNce2wBlYW3D8rd5W9DlpoasKosxNqTadMkR77Mn8e2qARcDrUGktEklqcWt3pqqk0Ks3nWz7NataQhKtWWSdGjobUCLOKI3F+3JUhFiBK2eDD/cCTo09sRTnBAvgsxSlBkXcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SoXCLjRb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SoXCLjRb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nr7CGw0V1buKl4iT4u52NpbKI4yhiFz61ZrkSZGcxuE=; b=SoXCLjRb1DdmBMtYzvvDg8eulq
	kKMVGc8Y/0rWti5A1JkmyHRHs6iGo+d8g/aA6CdOWTy459Ca1jbuLr8qCzOIDnBBmyhKj52ix6zSP
	trNVvjysfEpEhYLMR0tzh/ycTx7kVQgHrj3WEY0ZP9jG0BLXuTgXHEu0Ohu45hnG6a3QHOLhhP1gD
	YzYSQBx5U4MQqXtKvMbWw5cImMXejLfhhbflvmmw+mQNdHHXw55+J6V38RqXM9cVlq+ll3WBXJdaT
	JHu98IKbkSaOlx4DfU4g6cAuF/m9taTz7p2ouxF6+NgervgbNSvTiQ+A/dvNTwALaWTM0rcr4rVOW
	HY2fLWZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbvw8-00000000nwQ-47gx;
	Tue, 23 Jun 2026 07:52:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9615C3032AC; Tue, 23 Jun 2026 09:52:45 +0200 (CEST)
Date: Tue, 23 Jun 2026 09:52:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2 1/2] sched_ext: Make kernel/sched/ext/
 sources self-contained for clangd
Message-ID: <20260623075245.GT48970@noisy.programming.kicks-ass.net>
References: <20260622173904.1169407-1-tj@kernel.org>
 <903233e7c06ee5f3ea843e5b923bb7c6@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903233e7c06ee5f3ea843e5b923bb7c6@kernel.org>

On Mon, Jun 22, 2026 at 11:05:43AM -1000, Tejun Heo wrote:
> Hello,
> 
> Applied 1-2 to sched_ext/for-7.2 with Andrea's Reviewed-by added.

Thanks!
