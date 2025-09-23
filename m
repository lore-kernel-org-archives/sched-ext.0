Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0FA41;
	Tue, 23 Sep 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640507; cv=none; b=KqJJdKrp79mvHIJo2HnlcN1t9Fp2VLOPOuN86kbYEK1I/pzLYz0GssibMlbzTfacn1rdt1bXDT2sWMFfENilk2XFpOoK/cU6pJGD3l3/SXD5OWaPP/tpy0f2YIXD+kBsWIsOVi7wajCyFx2tWqmVXwncZLvvdcHJ9gIoE+bUxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640507; c=relaxed/simple;
	bh=plDR9nMP8C99jqd3G+Y5PjbgPK0ItQBrPdineYDdl5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBJbMMNPUdiX4e3hh+LWDZJ9Saj7Es9q6n0esnyQsVPW4iiXrlC+9LLBFzmNYs1f6CqPD9+/7Ace9HvtlmQfhXrlaQnWrQDBbqZpeEKLLcmsn4k4AbQkOHwNLUcZDKAhLDsxwWuJwEUxf32RYcXi7qGkyaUllC0rLIXYMX/bZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmtTDP0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmtTDP0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A5C4CEF5;
	Tue, 23 Sep 2025 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640506;
	bh=plDR9nMP8C99jqd3G+Y5PjbgPK0ItQBrPdineYDdl5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmtTDP0KZHYQ7x4UQfRn4686PtTrxvtGa8g17ougq2rPBTU+NwFuYSVdSnQvBSwd6
	 5O70JCWAE5q04XHRCdtMSxjm/OUdd/5zFatkT81EAZDJTBJSDv/x2viyVM8Y6o76tr
	 Jk/j5gnM/iRwBr+fVq4epA049ZRj83KNwGNbLc/TRyeRFc/TSlgWbwzLGoN7GJ/lCW
	 iPKcKAkM5F3gKvZxjZ7Iy/y5gqEUZhqwLAtBvJeuNGJSO114WlMME+OLDNeEdAGEkv
	 xmErP3Z7B1wdqhe+7ytqVC7KBe3z8oFEnFgA3+2yqWU4aLOotUPeeen8PdKKsRuAKS
	 wFQb+nsCBnPag==
Date: Tue, 23 Sep 2025 05:15:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc7
Message-ID: <aNK5ee-9NScZ-l_r@slm.duckdns.org>
References: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
 <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>

On Tue, Sep 23, 2025 at 08:12:37AM -0700, Linus Torvalds wrote:
> On Mon, 22 Sept 2025 at 09:49, Tejun Heo <tj@kernel.org> wrote:
> >
> > sched_ext: Fixes for v6.17-rc7
> 
> Oops, and people point out that I have renamed you in the merge commit
> message due to a messed-up editing error.
> 
> As I removed the "es" from the "fixes", I apparently also removed the
> "Te" from "Tejun".
> 
> So now you are officially just "jun Heo". Sorry about that.

No worries. As long as you don't swap e and o in the last name, it's all
good.

-- 
tejun
