Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDF2DA759;
	Tue,  7 Jul 2026 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464379; cv=none; b=kNSr7utRpYB/Klh0WzeSs3RKakN9gtJWgy727vzCE4M0y3SKpe8wSOqEWaryxb9udLt/IVlzoHLEzO4j4+HBGTUEkir0mLLUbB1Hwv3W4OwXuPCNI1x1X8EZ966TJNphL5kzWh8bC96wo1+T9k1utdJlEtZ0doGSowTJsSbayAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464379; c=relaxed/simple;
	bh=0T96byKr+d2+y3FLuL2nVKVCQPzNnJcGcpuTV9KgPoE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lZH36QXIgtqEeePdBAdgY4AwSsGTQ1roWTqU4aLsheZmpBOZ0Vsg0bvOCqCL/OKhlAb2YwU0kt2+qPY8CtznCmPNbhlCjNh8R/zkkv2dHiySxoUNSi8TiqIqsFJkKOQohPQ+zyb3bxXBwQ1DqzJLLqa/eG4ALu/zXOuFDtoNNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiMdG9/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiMdG9/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254601F00A3A;
	Tue,  7 Jul 2026 22:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783464378;
	bh=0T96byKr+d2+y3FLuL2nVKVCQPzNnJcGcpuTV9KgPoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RiMdG9/jTvMQxuyacLbvUDwLJSpupg+l4MQvKp2TlPwCoGscrcVFKuhk93uW4nqWM
	 zvYS6bU28emWU6LaGBU/EexWNvrz1KCPaztyxEYF2N3iG6ltnfIP3uUREFYzIiQQ5o
	 /ZcpUmmnauPIKJAX/tBZbPkNWR6CdmqloDp61Jzt95S/sVa46feMOZebyL3SoWuexe
	 iVSeCA9bVwx7z70yOuqqu0eDQCk1QG+yB7lyPpxRdJ0+jawYSXrnJ7k3a79LaMUt19
	 Ob8cUSjMJxVmy3sOCOXWAQ7WbUKeRiKkugZoEDPqEDJI5oUnbVjdZIsEc5wWQT6gaO
	 Up/oal03uwG8w==
Date: Tue, 07 Jul 2026 12:46:17 -1000
Message-ID: <2d3d31a802b30f340248db4a986cfa4c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Pat Somaru <patso@likewhatevs.io>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v2] sched_ext: Add tracepoint for scheduler exit
In-Reply-To: <20260707090314.2567145-1-patso@likewhatevs.io>
References: <20260707090314.2567145-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Pat.

Thanks, but name and level don't pin down a scheduler in a hierarchy -
same-program instances under sibling cgroups share both. Recording
sub_cgroup_id and cgrp_path too would make the events self-identifying. Both
are already on sch. Care to add them in a v3?

Thanks.

--
tejun
