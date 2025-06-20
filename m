Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55373284B5A;
	Fri, 20 Jun 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412680; cv=none; b=PwIIHf8VqmZpDNzUd4QxZEtjUbnYsveVKmesYmiefypy80p1bPAZnmWozjAU9hoIXJtr0v8voewKn/kpp1ZNiag56VSOqEKaiGsJBuz1Ut8UzwgoeyDWlIVFfflnZKLyCqQEEm3GlxML9yaS+Adg1NoqNej5/CWyjHc12y01lcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412680; c=relaxed/simple;
	bh=ZjPuDCqIMrI4P+agJWfduPColDMJtCPQ2u9MU5EafQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ehdsuasl6QL6u7nWJEvws+hCYCrjyZkdaGzM9UoULwTW0eCuBgzYcBaUCbGZL3A+Mizh4oe+51kru8+S3zTBXj7JV7tveTGRkidfPnaL/j3tdJfKq9XWlQlyTwOrjd5poqOSsMudJU+ob0bskuesNEoyt8IrnTZIcX/JDEMkTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XxhRQMUI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XxhRQMUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h5dAMKuOGUNtWrHYewajy26HHdkiJ+ekMfIX+V6Iy9o=; b=XxhRQMUIUrFxK003bxBk0gWIrv
	rsMmv/1Ig/tgbZzPPwWzhKUFzjr2naQI9URkuD4If1/OL8n5UkVt155ICmuOoRawTO/TZpgUljj0/
	P0w3l/9ndoSfprvN/138YrAPKrxum2o4Pr/SSZmP5YzGK9ysNW76FdKKw4R9F1YbObwKwfc1GWsUx
	N41DzMvd+SqC+83cmBvFI9j8FLzkXzBd/AccrylYipIGzD8Yed9TRJ6upXepwk95wCJEcq9eaiekb
	ZrZIR0gaKOvICzps8PxQ8NBqlmBYZeWBQ6vtjZZd7mwyfRHvqT4AMfUdS69Uo9Z5yQC+uIelzVJQO
	9nN/8tcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSYIU-0000000CGKF-4A9q;
	Fri, 20 Jun 2025 09:44:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 49C7E308989; Fri, 20 Jun 2025 11:44:34 +0200 (CEST)
Date: Fri, 20 Jun 2025 11:44:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH sched_ext/for-6.17 1/2] sched_ext, sched/core: Factor out
 struct scx_task_group
Message-ID: <20250620094434.GL1613200@noisy.programming.kicks-ass.net>
References: <aEzRVj5ha38RAEr5@slm.duckdns.org>
 <20250617085027.GM1613376@noisy.programming.kicks-ass.net>
 <aFGyK-J2pLN-fOf0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFGyK-J2pLN-fOf0@slm.duckdns.org>

On Tue, Jun 17, 2025 at 08:21:31AM -1000, Tejun Heo wrote:
> On Tue, Jun 17, 2025 at 10:50:27AM +0200, Peter Zijlstra wrote:
> > How do you want to do this dependency on the bandwidth rework? Should I
> > take those patches into tip/sched/core and then you base your tree on
> > top of that?
> 
> Yes, if you apply these to tip/sched/core, I can pull that into
> sched_ext/for-6.17 and apply the rest.

Done, thanks!
