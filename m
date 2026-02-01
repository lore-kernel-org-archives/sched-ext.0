Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94C1CAA7D;
	Sun,  1 Feb 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967815; cv=none; b=YnbI9zgq4Hf/WTMozDGjkZns08x0QmdifwJOoj2cGEz6xuElD1AGymMMy7h6QlMIHsOkiO/tCSB3bGMIHxN5uCXf5H+v4NdbqaZ6QWJBy0TT1krVcHI2d78pPCnQ1QmiXRBmHEuW8yKp4nFPEA5s9SyyAlJyyvqHZzRqn6VbeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967815; c=relaxed/simple;
	bh=RU90Hhf4Yr5Sz+sMGH2QRHqIakMsAvwg1YfnlMziPCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwH5PsGgBjWyhi3R5URSbYxLw/eBUm379EXpx8NZY7zkR4SlouLxj3gsgKAbZqJkWS3wIDjlI2r+52fbPrLLZNBTSi6tm/sC/amP5Pqf17YFAaZkF/wx9Ejz0Dq8p5DR8a5D2t6wI94ephyoA7hvOyJy+hzgwshW3N01tqP97ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdcu86Wh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdcu86Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FCFC4CEF7;
	Sun,  1 Feb 2026 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769967815;
	bh=RU90Hhf4Yr5Sz+sMGH2QRHqIakMsAvwg1YfnlMziPCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xdcu86Wh0leZu4shq/KYoO4DuJ2zZBxzTnTXqgpSVM65j78qk6LTb/1Xqcd3PApqv
	 CEghasHo7LtxnJLz0YPwBdOi299XwbzzTc12qBdy9roaX3v4qIRApFgTHkFpFf5k+3
	 Rv0oLiEavjZLqEA7kZDFFhNpQ2XW1kFdVfV+jgS5xyExRBEjoDFNzf8aCib7TSh4Li
	 dsjWIMaRoXjKp6lQ4shu4I3q+JbTcKsBaabZbnd202vUOJV/FHEJRCRiCZ5sDBaYcv
	 xuqZ2mFSNidHj3mOTeezMMFKGw05K45R3JrIUYkWVt+yNOuSL4I11rIV5SIcghkkpX
	 0mp+r9M+7OzzA==
Date: Sun, 1 Feb 2026 07:43:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aX-QxWngrRcOj3PT@slm.duckdns.org>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
 <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG1WJEB6B0AC.151EBIUYXCR55@google.com>

Hello,

Sorry about tardiness.

On Fri, Jan 30, 2026 at 11:54:00AM +0000, Kuba Piecuch wrote:
> Is "local" short for "local or global", i.e. not user-created?

Yes, maybe it'd be useful to come up with a terminology for them. e.g.
terminal - once a task reaches a terminal DSQ, the only way that the BPF
scheduler can affect the task is by triggering re-enqueue (although we don't
yet support reenqueueing global DSQs).

Thanks.

-- 
tejun
