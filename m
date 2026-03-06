Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4773793D9;
	Fri,  6 Mar 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786685; cv=none; b=n6GNjnwnnTXWjojJCmqHY+68H1zK0bGwLhtUBtPgbY7e8viUBJQRZVSnPRyUrtexPLbJWOYcM7/4fvEKAB2tuScbDiedB9rQfq6KTGgtYNpaE3c3ugKnjrBxe4v7FQu5v8bjkzqjKKJjJ41KDX/0DOXwhgh9p/tOpLsWDEJ7i9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786685; c=relaxed/simple;
	bh=UKXon3C/tgvufjmbdWUMDdJFTxHC7o4JDKPJyCf/Dqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSmF356/6RaG24OJsE8fpbz6cXpdNreQTN52Ohdo8Fqcq847eoYdPazOdlaqsQ/f9JuIVcazJJ8UPc9uMtd/Keae2XYZWhXxQl4OmE7UMLvrndXsp536QcsBMPQXhxSnaks9vZvdhP7H8yYfw9NuDtIPjmgLWzHNjlZS49gE020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P17dfvTg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P17dfvTg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=siH8Uay9rsvHZNsURap947AWEgilUL6NWi85Y5ZuyPc=; b=P17dfvTgRXOiD5/5qC2CHu81XX
	BtZpT9+cINQRo30zt4IE8oRgE1jLyB9qATWCOJaL7uXTJWVqJK7MM4zxo2tr7TsTJSgSt/DrgsVly
	sx0zr1lOB5xSYkKcr4Sy/pUBX45QAoAXcItef6XB6HFdzIBlmtB2I1PGp0f8zGldvQCiQX5cY8knX
	czEM0SKriISMHdNivT1vx1BzL+0XBYVL23tz6LZvhPFoo6eLE7/RKQ1nT3arwWKFS0/7CfHxGuO17
	VNzxnzrXuiE/Bo42wJJWHJ5gMqchTZ9818yZHTn7kGYtec7BJpF1v/HOAJm4qNd744yMIebf/GAjj
	YzC/E6ag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyQnX-0000000GPk8-2Y7z;
	Fri, 06 Mar 2026 08:44:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2BF430316A; Fri, 06 Mar 2026 09:44:32 +0100 (CET)
Date: Fri, 6 Mar 2026 09:44:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCH 03/34] sched/core: Swap the order between
 sched_post_fork() and cgroup_post_fork()
Message-ID: <20260306084432.GS1282955@noisy.programming.kicks-ass.net>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-4-tj@kernel.org>
 <9785874e854a32bcd0e393e06357b81e@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9785874e854a32bcd0e393e06357b81e@kernel.org>

On Thu, Mar 05, 2026 at 06:17:30PM -1000, Tejun Heo wrote:
> Hello, Peter,
> 
> How do you want to route this patch? I can take it through sched_ext tree
> if that works for you, or you can pick it up on the sched/core side. Please
> let me know.

It seems part of this larger patch set (that I've not seen in its
entirety), and its mostly about fork.c where I don't foresee significant
merge conflicts, so it might be best if you just keep the lot together
and take it through the sched_ext tree.

Ack from me and all that.
