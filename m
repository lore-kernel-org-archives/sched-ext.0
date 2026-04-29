Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0F381AED;
	Wed, 29 Apr 2026 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482408; cv=none; b=SBx0BirvRcpUQzP3uyvu6H7xsYPqIXb8wiijIfDwnTrUzaE500zxUbMj2+IRUVApjajqg53mSN/hDqX1kfU+vBXFLIGyMVgJXy/rnlMVn2+8LHMoU79XsnNE+okT5Fij4Ua/9JymJPRIwrtXOW6OWXQqiG48yUdxdgInWuVNjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482408; c=relaxed/simple;
	bh=W+e85/3UUoxojKZye3dsivHqpEq/haQzQCWst1X+ZwU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=s4ZmbQgIbuvZ2cTBn2c1BoMXW0LMMtyWB8c+fItbg82bQ29QJUqtB+OIC2w0Yw23HHtIqz3rEOSMR1UZtIwbi+scBWqIhoURupqH0aAY+qyfKZakG1emaZgxT+n1L5RTIwCnuFQTYt5cmV6iWGSuYib6Y1tKn8L2t6de6/uB7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5U9w0D1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5U9w0D1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB54C19425;
	Wed, 29 Apr 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777482408;
	bh=W+e85/3UUoxojKZye3dsivHqpEq/haQzQCWst1X+ZwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5U9w0D1jQStQnXjkurXOq/7KB/0A5xQYJ7mc0EsNm72V0ZWgJEi8casmrt6E/GP3
	 Js15bcYjrDengjznFqG9yRQe80xSvoUwZDXLTO3sx0EFC36h33M0kWyQ6kBvwbrfbe
	 gIyMX2FGFm3w8LpeqRCsSiLL0jnkYTEoOE0XuYExW0wr+qQb/dtNr2oZOYBcB5REpp
	 +1iC68c7Ax1ZMbIRQr+k+3CVzu0nQh0eUVj5Vllj+4hmy4ubxsqkV1zPdBc0R8uCPK
	 VU4gfMdn0j4aJhDX0q8chkwKZOBt6g6koDRhedbX4nUeeyCT31CYoamQkheVJ0XgY0
	 N7DSv/SYea79w==
Date: Wed, 29 Apr 2026 07:06:46 -1000
Message-ID: <cfed3836a31231df1b6119d02f77ecb8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 08/17] sched_ext: Add scx_bpf_cid_override() kfunc
In-Reply-To: <afIQmB4H6li6jL4I@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-9-tj@kernel.org>
 <afIQmB4H6li6jL4I@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

I don't think we need to gate it. The override clears scx_cid_topo[]
to SCX_CID_TOPO_NEG, so subsequent scx_bpf_cid_topo() lookups return
the well-defined "no topo" sentinel. The scheduler that overrode the
mapping has already opted out of the auto-probed topology.

Thanks.

--
tejun
