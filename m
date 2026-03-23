Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06E3CBE9B;
	Mon, 23 Mar 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287744; cv=none; b=MSqr6nilHNHWLWKL67x28Ovvf6ZJrGihPdd3iYV/u/+9klpObayZxwH9i+cy1g7nxQyCHdly9nBmz2pfGEkddKMuI0i2+S8N6Vm6FqNiHPvlGAC9Q20tkbqgVeLDl5EluLMNIp8rcXgbOpJMlYI1yoL86CAt54C5Zl76yhJzCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287744; c=relaxed/simple;
	bh=tV8VB/MvjswR9X2QWfGGB2iCl5dwxmUk2Sf8iHpsbSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7A9gIUSEvoPGK8iPEKeo7dInUZV1XXE/yX0GmXvBg6HLWHg2DzXHpPHSanCTPCelzf/WPxwwkUXIRgo9mfuspwWkV/jkkGsZtWiHicG/zTxdFx2B0pzwlg6R/8fFEQgeY2PvlKGYWGBlhs9f7nfzTgSUqWibaX+Uw59GGRS/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfeFRz40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfeFRz40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C84C2BC9E;
	Mon, 23 Mar 2026 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774287743;
	bh=tV8VB/MvjswR9X2QWfGGB2iCl5dwxmUk2Sf8iHpsbSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfeFRz40xYwHdw1YaDgLp4KP5s69PwlNE1KUyDAcxjCZRCMegOp07zxFBGagbj+df
	 iwSTtksVXdCWDdDkKs5umeNLhlFl6ZI5qa63x3T61czhrODMpi8lO2MVczb6OOekSM
	 I9p1QUsOI+XG3hYCEHKXTc0sqxICDqeXeB9WVXXRohhq3658ZjA0W2LFpQvcbaO2hX
	 dC7hv7RBQTd50IvW/gt+mP7FHkUP6PlY0l9u1Nop8/Ff+n9AjyQyjhyd+yQ+bAM4kV
	 5K8GchxfVySXgbtSt0bWE8QPNl2vANa+BQbWuWhKP6tRijhzizCD737Eqyy05F3iqe
	 KTbsq6DwMlFSw==
Date: Mon, 23 Mar 2026 07:42:22 -1000
From: Tejun Heo <tj@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] kernel: Use trace_call__##name() at guarded
 tracepoint call sites
Message-ID: <acF7fhKhGFWQfAk-@slm.duckdns.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260323160052.17528-3-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323160052.17528-3-vineeth@bitbyteword.org>

On Mon, Mar 23, 2026 at 12:00:21PM -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
