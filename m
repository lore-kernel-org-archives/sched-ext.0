Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CE2EC0A7;
	Sun, 17 May 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045318; cv=none; b=GYNtIJTHRI/csiBjdMNnKh6e/xJVMUzPPybKroqQRzlbLgObbX0xaF5XDU+GC48yajjSnXybldWiSO76QUcL8lnlphNJbyf6/OBmYIFj4hW4DVgjDT3JmDMT89T8zkgkoHisbXOvO4gmiMPMnVzSq0a2GvwB13xyGDDGbIbivjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045318; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Wo394cvNsSn+YsyBAjZlFnd5piWfR7uEuDwD7WRrO1WUnxC3uaydCycxzFTbyDjZN3cPXCeJ6ipHLM71D051uMojsy1EWL1plr+4Org5bcWKNNjok/XYt2G/wEkJ1N4GjPKhlQS6jGa2w4oeLacXmV7PpcxPjxltk5HoyMxW5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX/12tXk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX/12tXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2309C2BCB0;
	Sun, 17 May 2026 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779045317;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KX/12tXkW6TOuxWU7cmNaVB90S9+Nn/RYBNEtNZawLgOO5GMR+aph6lPXlMs7orZG
	 FWH+5rrzgFSwVs4qJjXEZl1Vp8tcHrQBxUZsxF8Fa5RY5m0Xh2Ly4c6QqA6klxW6hj
	 VTam2iVJ8Ypc1uCyaZwCKmi3tHN6QPfDkh3AU0hmEiKHKzd/dVlaobad45tncRmA0G
	 EPIXoz6wbdz8n+4jbBWtekfpvLSsQ5kEkSEsi/j1WFhzmYjFUivEavip8PK68QvaQo
	 j0Bw2dHpmo4kSWk+FJr03ldoW/xaZo0a4m396EFKW4EQkQLVU6+AZ4E88xoDCwZeFx
	 GweTtJHm8Ef5w==
Date: Sun, 17 May 2026 09:15:16 -1000
Message-ID: <1d83a923a8bf74eb2e3b5efd45fc2090@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix deadlock between scx_root_disable() and concurrent forks
In-Reply-To: <362a365eb559003ed21c6dac12d92c5d@kernel.org>
References: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
 <362a365eb559003ed21c6dac12d92c5d@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
