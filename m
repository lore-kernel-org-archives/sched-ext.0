Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708B1C860C;
	Wed, 25 Feb 2026 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005594; cv=none; b=kTpESDSPzYVcb5If53dXAn+5y7FiqeecfOx73HLgaJz7sV72fJ8LITPEnJxZhNK/Hdv6nZQUSNQZe1CBuWM82u017AcUPZCZU7pz1CeV1Mood0yo8DsjvtU4ERH+C3dcYNvwTquJBqkLcZtIsmiSAKojPEeNdXwZAfytV9HjIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005594; c=relaxed/simple;
	bh=lwbCFLraA1zhPh76lnhS66+D5N/BPfd7q3O/dprA6bA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qyvIVlAYxoJghtQy9Abrrc8fG+dcFMkN3TH2vETWH3NBzivc04xEeUcn3eD68BnftQHEZLDgjqLtLID2sxODls9bCQvz283Go8qr5J627f+LEgA+oVlAlfAp+E8TM6QtjLI/9OspaCQFUrBnpfdkmrOQ8YBwrjv53EtFk6LNKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCEXZG6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCEXZG6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C488C116D0;
	Wed, 25 Feb 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772005593;
	bh=lwbCFLraA1zhPh76lnhS66+D5N/BPfd7q3O/dprA6bA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nCEXZG6NuZLgPX4PiDjdple5EbvJyuxL6Hd5aFTiWGeQFnZaC8ewdw8lqFWsCgzvM
	 zUQ6GINNi5Fb6IObSYFJDVI7YpL4WmDmllEIQhEuxYBTDP64+MD47X3jPedVJXDoBB
	 8c5Mr7HPd/tNigK/2aa8jky2JewdEdB0B3blFDa9ANjB5w8QMd7qdyKl8LVDa8wqh/
	 XKJlhnpjPFXg/FyZgKVrl9+MnA/68xdPxK6KeV641DE0pP2ASjZmF0B7H44jbvzUzD
	 3i32ZIXK6K4XSEvRHxFrteIoQiBZ3OsTZFEFyApcqZbBn20xs2C3/kFdcp1iD6BUQN
	 +9looZGKvr+LA==
Date: Tue, 24 Feb 2026 21:46:32 -1000
Message-ID: <1c3f0e92d2e16d31004a5489e91d63f3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 void@manifault.com,
 changwoo@igalia.com,
 emil@etsalapatis.com,
 stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Disable preemption
 between scx_claim_exit() and kicking helper work
In-Reply-To: <aZ6Z-JrJM6nO_XsT@gpd4>
References: <20260225050055.1069822-1-tj@kernel.org>
 <aZ6Z-JrJM6nO_XsT@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, Feb 25, 2026 at 07:43:04AM +0100, Andrea Righi wrote:
> I think the same race window already existed even before this commit, we
> were just doing atomic_try_cmpxchg() directly, instead of using the
> scx_claim_exit() helper.
>
> So, probably the right target should be f0e1a0643a59b ("sched_ext:
> Implement BPF extensible scheduler class").

You're right. Updated the Fixes tag and stable Cc to v6.12+.

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
