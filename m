Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8803CF054;
	Wed,  8 Jul 2026 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537782; cv=none; b=OJHBePGFi36dmu278DeA6q6zjDsOxI3Vl8c3AAiX6mizLw9stwdX3Y00Cf8A8E6c7yd1Dyj8criweOptkVlK9evOq0bjEpGSoUUN4AhU+9UNnBWQBTmHWQXIY+METXOV7/P5K/tnUmdtWLxN+2TCKmn+XOkFi1H91yN83wWweO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537782; c=relaxed/simple;
	bh=9yaX0KPjssk6vorZ57AZ7n3XaT35VbMLksrzaVUQb/s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hdbGwLyM6Fqz66g1FOPnz9Jq4MPns85xJ6Nn0Y3Uqqibs9TD3R4JOZrlL5444Nu/6mqHwdT/0jyc7SwWaoZDQyh2b4U6gGDpzUi6HRoiFQOiao7v8EnMg/1Sl1AUqoLZzi0GkJZhqzdpefdXdsaOwEgtsa2YyvGN9g4sCPcS28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZibEJsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZibEJsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA481F00A3F;
	Wed,  8 Jul 2026 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537781;
	bh=FyNfpOJQNTGyDpMZKeBrpBaQVGja3NIWcHJsx0DUXK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZibEJsRkw2+uSmT3YZzKo0z07k3Qmzlo86KmmjlXJmF60cTEtW9THoV64oe/4Qrg
	 uuqaEpY9vBKGcj8G7rUQTzlxWj1SRrlCtOAl0JtSoSPQMRjXd0RLcxK7uIInr88ciH
	 q8R4FtypYvFW0+g9LGun17XfeVnD1LSla5mvqkzdZ3DzQlEOsteUkBySrewegH95cb
	 3b7L4yAfKO2GUOmEusyzfQv9LWnqmzSnB+0q6cZI+dWpPdhfPBpO2/PljtOPoejWPV
	 dbfQemPshdeckuTLATJ+a7eUhImvZlsasmjhFvTEHmohYIrOKPfZ50ptGdWjy297XH
	 yM/y/J7K84PEA==
Date: Wed, 08 Jul 2026 09:09:40 -1000
Message-ID: <50865a7bd33150dd7f8b1beb56c82499@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 24/36] sched_ext: Add reject DSQ for cap-rejected dispatches
In-Reply-To: <20260707003858.1BBB11F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-25-tj@kernel.org> <20260707003858.1BBB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:38:57 +0000, sashiko-bot@kernel.org wrote:
> - [High] The CPU incorrectly goes idle and strands tasks when a consumed task is diverted to reject_dsq.

The divert does happen, but the reject DSQ is drained in the same
__schedule() cycle: the divert queues a deferred balance callback that
runs scx_reenq_reject() before the cpu settles, so the task doesn't
strand. No watchdog-length stall. No change.

Thanks.

-- 
tejun
