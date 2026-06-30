Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08E22424C;
	Tue, 30 Jun 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829461; cv=none; b=KpkQ9YETZULazy9Nu5Y1b9sFgen/G0Q7dupu1LtyVClJTlpzk4OLcs9/jkfz0f1xlw8tXk17CtvhUUwDloL1jEBi/T2ysZRjp+QNzkGXRN9hZo/7LtfWh1ifJ99TDGg/0sx6AoatzCQk+kDWBJKzmVgtLmwQgXDQk02i02ayR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829461; c=relaxed/simple;
	bh=7dDNS81/1tzvD4qVw8CWU9wOcXbBmuop35FTYtIurOg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dE177lR5N1iO35ccBt0M6nGmAtuYUQxAJSgz70PqOCUk47v6/YYiij7Z2c3FnffeAqpNDZdz8ZDoMhsp8/NWdoeY8bdcwDMCt00b77eGNktWlssnKNA7smWkzJblyzU0hNFVegpGo9+n4JnBqcOayIs3KJYzD+P57HqNFkU8QCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxfVu1uI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxfVu1uI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC271F000E9;
	Tue, 30 Jun 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829460;
	bh=7dDNS81/1tzvD4qVw8CWU9wOcXbBmuop35FTYtIurOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VxfVu1uIC/RkmtNZz+h0soogcimYZQVwrj1G+txpfuAUgqfnLUy0rhsQg4Ys6P8k8
	 qv8fK6LW9uK/ESUqBb+HdaUdtHcr/AaZrkXAcf052GQb3YSXLDUWgZMeoL3qcd2h7I
	 4fJnv89MhJZFoBz88o2uyJLK6qA1/7BJdQ/NIPPYhJVeWGdYbnHa1sxtdnzRlLw1ty
	 udPcTUAVgyDoq6RGvbkiXm4SEViFlDwrYozRwjdk4oI5IZ6TMhJ2GalrJ6Ek4cykFu
	 Ot3Gh1UaJFYSVYIXH0BNHTLomp/0MCargZWCiBPJZXRwiKFvgBtEmz40mojSUSFECV
	 rCAeQk77CKutQ==
Date: Tue, 30 Jun 2026 04:24:19 -1000
Message-ID: <b16d24f6abd445709df2528733fd1260@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Kuba Piecuch <jpiecuch@google.com>,
	"Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Subject: Re: [PATCH v3] sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
In-Reply-To: <20260629225548.3562257-1-tj@kernel.org>
References: <20260629225548.3562257-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2-fixes.

Thanks.
--
tejun
