Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C727239E6F
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554435; cv=none; b=m2hyLwGYrM9TdafF78Bpu8f8jZogAbDrSqm7tpOeyEVKSS709vh25vIfGUfg4xNu86WeMcVTPhmCtahSjM5etrHuQtCZ4OQkF053Su+ehBprxlSMR+FnMUOJVHKBpOK7FrLjjN3c1R/YJ8w795xVnMDUUwxnRCQAbfpzHJSaBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554435; c=relaxed/simple;
	bh=RUeazSCgLkLLG2Pwea3Nkv3s/do9vrjubir3YRHqQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxOIoQVPvwqCm49Htd7F7Bve9YdoSfHunIBez3SASQKWecL9BGQKlat0VbBY9SNOvhDjPYXzEa892Sm9z5o8yVzMf1Tiv//ZN9fZps7+YZPmjlt7UolJ8uYZ3iSHgmmpzC9cEptsFRLuADAbZdUmJ0ruA/CEtFGRomYO/pn/0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzT8UGh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzT8UGh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B68C116C6;
	Thu, 26 Mar 2026 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554434;
	bh=RUeazSCgLkLLG2Pwea3Nkv3s/do9vrjubir3YRHqQ2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzT8UGh7Xb4l/KpqSOADoJZGwqxjWfxbfv80Cfiuuvi5YeFj5Nw7RmDfsrqSHq86m
	 JsgS6QpH7v+SfhxXNcx16ShpGX22a1DzJP2CBi9IMBTAODIkgk2RZfkl/Hp6oKmYpc
	 pivycQV6yAxvkMZbn06qwbmQgQzrQroP9tjUXj8eN4mMprdf2IqmKiEIJ6FOrMCqFG
	 jmhaL/BECtjZS5I3ek6IEvQAJyFMekOVVo2aQBvSQXDY595eXPF37LuaBpZ4wvuKEk
	 HibYKGONhmEh8cFr2ma3NSYfPIfRZwhW4QqijngOG+n3e4xUYoFW3LF7/wFtiloYRO
	 8U2E7uXf2ohEA==
Date: Thu, 26 Mar 2026 09:47:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2() to
 handle SCX_DSQ_GLOBAL
Message-ID: <acWNQdI6JswOBY8P@slm.duckdns.org>
References: <20260326091756.816828-1-yphbchou0911@gmail.com>
 <acUXEy9NUVMb40Lh@slm.duckdns.org>
 <2bpxb64ymbxgtzodc5bxdmh5w7klr3xokyt7wccb2lzn3arxwp@yhu3jj4ury7w>
 <acWNH2Kp2k6K__Zj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acWNH2Kp2k6K__Zj@slm.duckdns.org>

On Thu, Mar 26, 2026 at 09:46:39AM -1000, Tejun Heo wrote:
> reenqueued. However, the BPF sched can directly iterate local DSQs or move
                                     ^
                                     can't 

> tasks in them. Global DSQ is similar but dosen't support reenq, mostly

-- 
tejun
