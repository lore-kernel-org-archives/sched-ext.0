Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE637E310;
	Mon,  2 Feb 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050730; cv=none; b=XX/Mwrxqo7zVUeFq8gSLs6YSiqGmtbV8kJNfR63pK53hEwVR6qRCGbPCHSpgXni0dGMh8+MEvqOoOAyTeBfqi73FEt28jKicizENbcHNIsCdqpBdaeKJU1SJtDSW1VBVAjdZAiVY9kzCGeGQyizJ0AIQMfCN7AUDB+1p4s0cRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050730; c=relaxed/simple;
	bh=A8tW6NDSGQMa3MgDyN9t9N1XSE3y+i+/KNrIaAA8+P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4ox4fyY/1yWXGUdgXwAr077bk2Gr2hQhpOqlSiV4kWyUO9Opx0jbluhxJMP8PzO/ABBdyxrZeD3aa5kZfjztPAYCP/uJw1Z0/ev1sdUXOPCC8a0uLlzzwR2x9ZBHQdNPSjLcy3zq4RRu1Oyj8t7vOlfgVug33iTHSGq465Gxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWqW9i+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWqW9i+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200CFC116C6;
	Mon,  2 Feb 2026 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770050730;
	bh=A8tW6NDSGQMa3MgDyN9t9N1XSE3y+i+/KNrIaAA8+P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWqW9i+mG02VzVmqWuAdS0R7e5W81EONmHZq1YndKic/4n5h9t1X3a9Geo/YFpoER
	 AZFhNWjQ0Ba3OCeTmX+AaHKeodUEcymHXjt0B3uoQKWwx8UJYY/QESiZj7IW4+Z+yY
	 bW1oX0V6R7s8qTyLQyQDNJ3kXB0MD6KiY2GLaupavSdUTBleaWsf2u9mAnXQfF4fgY
	 FcxfNAy89gUrBPPEck3ONZ+9+EtuU4fv9uXOWvCM+eqdnv5+8gJLVAy9bNsQEJz6SX
	 LKueBWLNWyTOkG1bUvxHlv/uAj8HjZhm6SmsOeuha5KRPQRPPJ4ov9JeAN9GdEqXCt
	 BPmKIHwL1hgKw==
Date: Mon, 2 Feb 2026 06:45:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v12 sched_ext/for-6.20] Add a deadline server for
 sched_ext tasks
Message-ID: <aYDUqdQquFcqj7rQ@slm.duckdns.org>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>

Hello,

On Mon, Jan 26, 2026 at 10:58:58AM +0100, Andrea Righi wrote:
> Changes in v12:
>  - Move dl_server execution state reset on stop fix to a separate patch
>    (https://lore.kernel.org/all/20260123161645.2181752-1-arighi@nvidia.com/)
>  - Removed per-patch changelog (keeping a global changelog here)
>  - Link to v11: https://lore.kernel.org/all/20260120215808.188032-1-arighi@nvidia.com/

Peter, Ingo, this patchset has been around the block for a long time and the
remaining deadline and debug patches are reviewed and seem fairly isolated.
Given that the patchset addresses an on-going issue, I'd prefer to land the
series before the merge window. If you want to route 1-3 (or the whole
series) through sched/core, please let me know. Otherwise, I can them
through sched_ext tree.

Thanks.

-- 
tejun
