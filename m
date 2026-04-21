Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89B3161A4;
	Tue, 21 Apr 2026 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796432; cv=none; b=OsQcQc93mE6WIiAsyXCzUYglB320Ia1X3WLPnJYN4EoACIk2w8MLgZ35SJ6Eu5uGBntQqSc8lRlXeS9dCqNl2/+rrZG8nSX9yq2YGiP4aYx9kU7CvPrpFhm5NMwvdVNtov+qQQtCVT2shl5U/KB4zLIdAMTZmhAYEgEQaUNJBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796432; c=relaxed/simple;
	bh=+t9nTE4/bWChwsn4ut0SHL9h3MG+8fi2ctEm+xiKelc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJkcLISBHm9n6BtT6xaqXxFNgK1remZm3sNDJ0jqAcwZ8q33yeqt+Bi2XNrCjaakFGlDY0JL3KIB9Z9+bA8MC0E9l1HHjq2FCnkcVDtOY+b32h6rPlO1eXZFuJu2ekPPZTdTGn9auTRgpOiKipI//pN0rm5+OgoOCyzxYrNnjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnrbBOM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnrbBOM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B16C2BCB0;
	Tue, 21 Apr 2026 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776796432;
	bh=+t9nTE4/bWChwsn4ut0SHL9h3MG+8fi2ctEm+xiKelc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnrbBOM9Bf+uIkFH/jNfSfEHMFt8UE7X1fi10qVe7aV0olfYPUd/ooB0mj7+8Q1I+
	 aJ4q6ZcmvPLuW9TBbYUh/nsB36knFJjyONPjsk74xGqK50llmOgKldhIByxMOP+V6q
	 D8zFlYBQn7lgPnyU0vEqAIP5KTZevvXEkYygyD8fb+UeTEfzpmfRoelQEP0cNvleQg
	 RWQBFjQDluQMO2TxS2v5hq3tDhV6N2BwuVLw2eurSIStMBe1vAUs/40lJxqxwHmvg7
	 s003aiqKKn4UO3+HpompqtNFX9BckTpj8Eua3GxJy1/FkcqU58CmS9rZ0u0JBYpHGv
	 GmjaEsJoBKOSQ==
Date: Tue, 21 Apr 2026 08:33:51 -1000
Message-ID: <366940a49ecc5307db2654c49b137a4a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCHSET sched_ext/for-7.2] sched_ext: Topological CPU IDs
 and cid-form struct_ops
In-Reply-To: <20260422015408.Gac88@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260422015408.Gac88@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hello, Cheng-Yang.

On Wed, Apr 22, 2026 at 02:18:56AM +0800, Cheng-Yang Chou wrote:
> Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Thanks, applied.

> 1. Regarding the ext_cid feature (same as ext_idle), is it feasible to
>    implement this within the BPF arena instead of the current approach?

No - cid-form struct_ops translates cids <-> cpus at the ops boundary,
so the kernel needs direct access to the mapping. Building it also
pulls from cpu_to_node() / cacheinfo / sibling masks which aren't
reachable from BPF.

> 2. I noticed rust/kernel/cpumask.rs is already in tree. ... would it be
>    a good time to start adding Rust abstractions ...

I'd wait for a concrete in-tree consumer before growing Rust
wrappers speculatively.

Thanks.

--
tejun
