Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125A1C5D44;
	Wed, 16 Jul 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673255; cv=none; b=G8AH0d5z/LZLhaHpU7hlRytbYLChr6M9F5nMuivongO0pdjX6P+3DnA8k3ize0yAD7nxNf+1RUxid3sGY+Xd/9N4U7/VEFC1EJPBZDjRK/tc03vNt6WBR8BsEwyxtyS2wMd66M7Q0yEZtNlBEnZYJL0SuHaB3YjBoS/c/ac8cEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673255; c=relaxed/simple;
	bh=iw4PyieIQi6kuO7rXJ60xVYzYOooOntjGNeOsZ5zieo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chRuZ+MB08PNu01F/DRC7sOc+4mCHfCT+1rj8ocMUm4JpG0T0sTGwZktY2KRNNRn6nP5pIU8IJL1oRbZEZwqSwC8G9OdpOPR2dvjrM8zfq1Gi07hvbZhY4jfTbLTEKTqb6RqNLcbcmxkLMQ56OC8mgvPEgET0pQ+rhuQ1ID7xnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GlX2PF9l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GlX2PF9l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YJ8jj1+LfJaIWyKuEoAy6vQtxhqaDsoQByOxilP1PJs=; b=GlX2PF9lngS6r37wLOB9xFCW68
	05mDzPOPkvdPjC8DpeDvRQDh8eEgmDYgwl6CE79Nj5HBQuiWuq9j1MAa4xC5zI6BHBdLfIEqaacaa
	0WNqBvuyTn5az5Jbxv3Ra4uQlNXzSUc/OBfmjM/oMUfYKwCivizIjNyd70MiMDiOSicVskczf3V9+
	sNTzSHQMz5g7X2dmPf+1cC35jAOrmbNkpFe5m79Dg2BgKMkz4AhqjaESsDZInVdrb00WfK0BsuEHS
	KNOATegszCEm5o/eXEhIliXIfYo2syxLsWMNtSx3UHj+zFGSCCSTjeWHWi7rfRVkIh4e9CskSNFkQ
	RlT0gZ3g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2NI-0000000GidN-2BZF;
	Wed, 16 Jul 2025 13:40:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 70F60300230; Wed, 16 Jul 2025 15:40:43 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:40:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <20250716134043.GA905792@noisy.programming.kicks-ass.net>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
 <d2ocjfutd6o6euvjhln5tj4sdnmlblgpy2papponnumtu5slcx@tfc6y5webosm>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ocjfutd6o6euvjhln5tj4sdnmlblgpy2papponnumtu5slcx@tfc6y5webosm>

On Wed, Jul 16, 2025 at 06:20:02AM -0700, Breno Leitao wrote:
> Hello Peter,
> 
> On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> > On Wed, Jul 16, 2025 at 02:51:28PM +0200, Peter Zijlstra wrote:
> > > Also, I don't seem to have this scx_layered
> 
> This is a rust scheduler that could be found at
> https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_layered

Well, that just means the Changelog is entirely useless. Please always
refer to in-tree code when describing a problem.
