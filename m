Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B148223324;
	Mon, 27 Oct 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589060; cv=none; b=E4kPtZLFbkLYOuNmkJIG2Mo2Tz6/FXfX9D/pEuP+M7n6lxFVRbb+acibVJAqAj9uZoEOp8kcT67KqJnxTR9o77S+c4YkLU2+xPTsXvBu4D52r8gdBSe0nGQuaE4nCDnZFN+1Zuk9lVRILST2LDarTEuo8UTMaVYN9N2htcMxvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589060; c=relaxed/simple;
	bh=JTg6Sb8dfE8YMHOCVIlr8GAXI6KppzQELslM5lFKPf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri0TFENXJzDqLF8XVszt6T7K1ArnvuEhYOTM3qnA1rk085ydnEJzUFQuGzv12ekyMqwQemPR6eW8rkuqWi6oZwKPDpdlhnFgiZNn+C4lOEIfhoUh7SFKe3uNgZ1refQi48MG5kFRNtBugdiJaddnS8BKOhRlyamK6g0SEv0ZPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8h4S+Vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8h4S+Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7982C4CEF1;
	Mon, 27 Oct 2025 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589059;
	bh=JTg6Sb8dfE8YMHOCVIlr8GAXI6KppzQELslM5lFKPf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8h4S+VjdSrQA9QsZrw2ag48tBRQ0ntfOeRcnDW9VJzBGRkisR7iqIx6hMqXz/Xw4
	 fvr8mRHn2cFIyuPm5HZhGIi6IIa2fmu1zq9vcPJt9anVP679obZ0nSoHfG3aD0edJM
	 6rGFl+ije91u25anqS2CRf2pLpxeKfNU/YoYYWPZcNlMucgNks7gBgOxokvIwul2hz
	 y3Q88zjuX9EZr+yS+R53/xC9DpVPUKmQqFsJIau5vo7da6u8j9QsxJTwAeMJ26/5Tx
	 iOpY1hqZ/NwNWuUO/64ajmKeBzYvJIJtQkx9XUT/cwlV3oTAmsu8PlEjtdd7rsOm7p
	 itmbHuXtahrtg==
Date: Mon, 27 Oct 2025 08:17:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aP-3QsygWJRn6Z2u@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
 <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
 <20251027181028.GB988547@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027181028.GB988547@noisy.programming.kicks-ass.net>

Hello,

On Mon, Oct 27, 2025 at 07:10:28PM +0100, Peter Zijlstra wrote:
...
> Just for my elucidation and such.. This is when ttwu() happens and the
> CPU is idle and you dispatch directly to it, expecting it to then go run
> that task. After which another wakeup/balance movement happens which
> places/moves a task from a higher priority class to that CPU, such that
> your initial (ext) task doesn't get to run after all. Right?

Yes, that's the scenario that I was thinking.

Thanks.

-- 
tejun
