Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08F377EA4;
	Wed, 29 Apr 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475803; cv=none; b=Bi1CzvtNmA4Cz2/Wy3tn2/w94w33rTb9+9gCt3X8fa3xOwNRwfEsdsrMd19a66QvAb00mnQuBB6GujWEa0qgVJv+3wY6OF36aqJXZP1QQpMsqhqzBj0DSxuLS+O/9enswovy6qs2LZPTOnd8o0rLcU2SxEX8yaTAjW/Bifihi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475803; c=relaxed/simple;
	bh=TkXvDVWeyYesbODeC4dNIudQAJZoUZyvVAKtq0EOVmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+RWEO0avKHKavM/4k8XJxRGCyLJoyq9xwqanvNgIAMn26rNIDnvlZsGdvZHeGN6+CwtySpfO2o0nLdxMOaerjliilhjSWvesSZ3ERl6lDJssGvyGWAFpAi7ee1kqF6Z9P2K8hFj2jGGXOHd+4JAPvjdew4ES1Z4qS4uHmAdbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuZB9Es2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuZB9Es2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345BAC19425;
	Wed, 29 Apr 2026 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475803;
	bh=TkXvDVWeyYesbODeC4dNIudQAJZoUZyvVAKtq0EOVmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuZB9Es2G9Aqbk93eZ18+QDtXq/e9Pa76b2+UwXc8YSsaCeHJMkztyYBpXiHv37iB
	 C5pO/QsjFSsquWZvr2XSW6M+U3P5HDJUcfNIUfHS2tAl7BPwdkGUL2IZI3AZPf/+go
	 8JJwEfyud3+moCktVulHv0atPqPFWviYYRUdGzRiiZsmZzLGjBhWBw6qk3Zihsa5kI
	 nObHWpqMmswVC4YxsgC3JuIGEKqu8lS085n7CqSE89RP72O801PGpnkrqeLfRfMTD+
	 8UBAuBuqCv1yBGNDLojnwNgL5T3+3n1cVSObtDVxi4Fj7PD3ctHN8wlFiLKOrpWjt+
	 MPLpe1Vx6mznA==
Date: Wed, 29 Apr 2026 05:16:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>, void@manifault.com,
	arighi@nvidia.com, kernel-dev@igalia.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 0/3] sched_ext: Improve exit-time diagnostics
Message-ID: <afIg2hB1zo7zkCog@slm.duckdns.org>
References: <20260429082318.420146-1-changwoo@igalia.com>
 <e7cbfc99b52b4b7059267bb81498179f@kernel.org>
 <20260429192218.G59fd@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429192218.G59fd@cchengyang.duckdns.org>

On Wed, Apr 29, 2026 at 07:29:30PM +0800, Cheng-Yang Chou wrote:
> Hi Tejun,
> 
> On Tue, Apr 28, 2026 at 10:57:27PM -1000, Tejun Heo wrote:
> > A few things I noticed that might be worth a follow-up:
> > 
> > 1. scx_rcu_cpu_stall() takes no cpu, so the captured exit_cpu ends
> >    up being the detector rather than the stalled one. We could
> >    probably plumb it through from print_other_cpu_stall(), where
> >    the stalled cpu is known.
> 
> Do you mean we should change the function signatures to pass the stalled
> CPU through, e.g. panic_on_rcu_stall(int stalled_cpu) and
> scx_rcu_cpu_stall(int stalled_cpu)?

Yeah.

Thanks.

-- 
tejun
