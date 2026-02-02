Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49F2C026E;
	Mon,  2 Feb 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063619; cv=none; b=CHoy1ChFuXGPt65XyzjmUE4Ss8yg/mNR7AF5PqQuWC2Y3pUJRtjB7hhTJ6qvZKq9akzljmqBv286Nr8FUwJRjh6Y3RAhw4Rino4fcIH7A6KkXc2KN7Rz2gQQoRZrPj9EwjPx+XmmO/HfTzz1LbgQpNZ/VBie6/ieVAh4M4cLc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063619; c=relaxed/simple;
	bh=/7bZAnvvBeBeGFDB52o6ZrlgwwVePrTXMfzH1urmXJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA+P46+WYK3hqVXu+uygKs5ZgvOWer7Qr+dU8qgQsM3LWgy8g40f8PQUZS+9zKXZMzLJYC6UdbVJZVbav23lbXNDx/XHTSR1NPIGy+bDZA5wiFX+3U0DiQwB3qVbGIhTqf3rrF0BIt1sZyY5MNHUoYIy+Aif27PjRlrMOIK9dWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTBiC4s8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTBiC4s8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93638C116C6;
	Mon,  2 Feb 2026 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770063618;
	bh=/7bZAnvvBeBeGFDB52o6ZrlgwwVePrTXMfzH1urmXJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTBiC4s8UYlzhsjQgma6tY8IMvQpGryePiDdonSrHNiOZE/TRbGg+hzke0kXPKf7X
	 DhKziNOSL9/bxlaAY/wHZQnrBSvBld3CbZ+QQsD3svBBm3Qw0rzMA0sSJ9mStI5PLE
	 cnUAvuIjG9ZoXSMekiuuesPBGUeRpTkfcIGmClM+mzITvQFf5tZ6WUPX/i7gbv4ZOm
	 75CP6/0NrGmTa+CkRuzPr1BrD1dylhEduqfoRk4BUyNQm7VGQC1TGNKiQhooy72ZbP
	 XRn27MjBqf+PGqjIXIu5ShUUWS63muJaL3upJqou+CNuLdf9paTJGeZCX38Uwz+Nes
	 2A7VdOM9ZsHvg==
Date: Mon, 2 Feb 2026 10:20:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v12 sched_ext/for-6.20] Add a deadline server for
 sched_ext tasks
Message-ID: <aYEHASWgedW7AVq1@slm.duckdns.org>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <aYDUqdQquFcqj7rQ@slm.duckdns.org>
 <20260202195634.GH1282955@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202195634.GH1282955@noisy.programming.kicks-ass.net>

On Mon, Feb 02, 2026 at 08:56:34PM +0100, Peter Zijlstra wrote:
> > Given that the patchset addresses an on-going issue, I'd prefer to land the
> > series before the merge window. If you want to route 1-3 (or the whole
> > series) through sched/core, please let me know. Otherwise, I can them
> > through sched_ext tree.
> 
> They seem to apply without issue to tip/sched/core, so if that works for
> you I suppose I can stick them all in.

Yeah, that sounds great. Thanks.

-- 
tejun
