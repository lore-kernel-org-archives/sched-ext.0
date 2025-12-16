Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A428D82A;
	Tue, 16 Dec 2025 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912697; cv=none; b=rvuUXR0hVnbfeY7VgcEq8x/IwNdf6eee/vNk+RXWayqstYBfMP43t+aJRacAfjyB8DXLKSAC4qaViJbT1l5v1UyUCGL0F00v1IFjtKacH8x1No3C6LbBxOwjaIyDhP6h+Q1s8oXt5bd0piVLbK7hPj47y7gO6xztWV5jPxWtm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912697; c=relaxed/simple;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WLDNA+HueypNWo3TFsARYa49t93hel/OTKYXWVePznpCopBAKi2Yt1CHgqSY5hMdn2IKMRbLG1PH7vweyzHqdugjf0zG2XIuEoj78LgCSOgsVUWiL38X+Qpw0Q2xEV9vFk8F0YYh9jxCP3JCY9iuBYy6RZ0bZRKRK3/Ltnaox/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAhCSBRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAhCSBRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC60C4CEF1;
	Tue, 16 Dec 2025 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765912696;
	bh=D11VZpRhmNiomMaDcpqQBghBTZIUSrMB1joo2gaaf7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rAhCSBROWA05/e3CjDdBxjJkE46H/gmv9mMloX/ybXYRZiMKoCrJ9pNquaS+djxZ1
	 uV/p8kaPsFpahEGyGDVTaGsQonxiZA7jrrH/DO2IWa7pqAdEzKbKG1MlDskeU2eFiG
	 nwdWAFMlHIYvwlKtYSrg3NK8mM88wJSdv/z3HjTqZP/o7Xg+wl5bK4Aj6CEpQcXMbS
	 blbukxg102qIra6R/XAo1pXFkSOZZTIZAytFYIWEDpGIQ+WG8wwAvmJXVCjFyVuwxg
	 K2mZHyxdrnAr0/z0+zITZiNlL/VbNjaEttxvmi2wSTbDL4fwqHTblkCYwzeuSV0zff
	 oqAvSKTC7bnEA==
Date: Tue, 16 Dec 2025 09:18:15 -1000
Message-ID: <95094cb8eb72687fd2559fd64382a695@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Jie <buaajxlj@163.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 liangjie@lixiang.com, kernel test robot <lkp@intel.com>,
 Dan Carpenter <error27@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: fix uninitialized ret on alloc_percpu() failure
In-Reply-To: <20251216093955.2928453-1-buaajxlj@163.com>
References: <20251216093955.2928453-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.

--
tejun
