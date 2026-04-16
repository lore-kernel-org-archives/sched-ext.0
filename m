Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8191BD9D0;
	Thu, 16 Apr 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776361731; cv=none; b=XOLChK8zoj5qtCILG99WRXW6I3a/DeGn0HzliJD1GZIZvK5dImLmypeK3+mkYESZBfMLH78Y5JSLTQzJ54hyT+SVO5iHbYZovFmYzW7Trfuk+T3qWMAxaD68uTUx5VZjaSyK7/rktEG84TclrNjmmDNZv0c9thkIOoYCW3xXMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776361731; c=relaxed/simple;
	bh=NVXh7vdkGsTkm3pisILvYlD+g0ojydL/PZNZSVDgTNM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tLguQBC7VQZlosHNraJ8DGNoGHwsGfWKEtvVLJVol3rmJ2dMyaeKfkDaxef8TNrJhhkO/6ABjKOlupc52yG0xkElZd4cmsDd96gF35NFu2TieMW6/LYFBNVvkNr9ED+hj4m84vLr7Nco8SCyfVlQsaj253mrxu0t5vmp9lZrWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUlmvJID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUlmvJID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496BAC2BCAF;
	Thu, 16 Apr 2026 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776361731;
	bh=NVXh7vdkGsTkm3pisILvYlD+g0ojydL/PZNZSVDgTNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WUlmvJIDA5tWB+ujg+3n9A4hlKjK5bH22qRXk9Uvzl8H1g3wP7LoqfC5q0nrK6V+B
	 l/0YlAa5WxpP3RAYEZoKvyg77dEbRE6Xyl1rgNdL4mWbfg7f4SVPrjBhHqRpAmQXg5
	 KS0dMEuR6yZ7vchicCbSU+5E28zo06vBP8naFXE0ZEsmKBh147ZAE497yiSMQ4hfK/
	 tZtU+mZnBcgVMUk7q5lXHG6yjd/cAtCVBwQPaFiRIJZ0XK9FXmfjYZQ7q2n/KyIuer
	 NFADWKlCl/4sJRchy/iipvu2HGES06JCZJkTj3Nch/zAgWxPkGyN581YutSnBQUXGX
	 vTgKsgtzGu/OQ==
Date: Thu, 16 Apr 2026 07:48:50 -1000
Message-ID: <669b5fbcaf1b2dc1bbc9bfcb12d2f3f9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.2] sched_ext: scx_qmap: Convert to BPF arena
In-Reply-To: <20260416172030.1417417-1-tj@kernel.org>
References: <20260416172030.1417417-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Tejun Heo (4):
>   sched_ext: scx_qmap: rename tctx to taskc
>   sched_ext: scx_qmap: move globals and cpu_ctx into a BPF arena map
>   sched_ext: scx_qmap: move task_ctx into a BPF arena slab
>   sched_ext: scx_qmap: replace FIFO queue maps with arena-backed lists

Applied 1-4 to sched_ext/for-7.2.

Thanks.

--
tejun
